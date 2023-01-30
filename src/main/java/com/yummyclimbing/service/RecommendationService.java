package com.yummyclimbing.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.RecommendationMapper;
import com.yummyclimbing.mapper.mountain.MountainInfoMapper;
import com.yummyclimbing.mapper.party.PartyInfoMapper;
import com.yummyclimbing.vo.RecommendationVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class RecommendationService {

	@Autowired
	private MountainInfoMapper mountainInfoMapper;

	@Autowired
	private PartyInfoMapper partyInfoMapper;

	@Autowired
	private RecommendationMapper recommendationMapper;

	// 매주 임의 추천할 산과 소모임 DB에 저장
	public boolean weeklyRecommend() {
		if (checkForDuplicate()) {
			return false;
		}
		
		List<Integer> miNumList = mountainInfoMapper.selectMiNumList();
		List<Integer> recommendedMiNumList = generateRecommendedNumList(miNumList, 3);
		return recommendPartys(recommendedMiNumList);
	}
	
	// 매일 임의 추천할 소모임 DB에 저장
	public boolean dailyRecommend() {
		if (checkForDuplicate()) {
			return false;
		}
		
		List<Integer> recommendedMiNumList = recommendationMapper.selectRecommendedMiNumList();
		return recommendPartys(recommendedMiNumList);
	}
	
	// 중복 확인 검사
	private boolean checkForDuplicate() {
		return recommendationMapper.selectCountForDuplicateVerification() >= 3;
	}
	
	// 산에 속한 소모임 임의로 선택해 DB에 저장
	private boolean recommendPartys(List<Integer> recommendedMiNumList) {
		int insertResult = 0; 	// 저장 결과
		int numCount = 0; 		// 저장 대상 개수
		RecommendationVO recommendation = new RecommendationVO();
				
		for (Integer recommendedMiNum : recommendedMiNumList) {
			recommendation.setMiNum(recommendedMiNum);
			List<Integer> piNumList = partyInfoMapper.selectPiNumListByMiNum(recommendedMiNum);
			if (piNumList.size() == 0) {	// 산에 속한 소모임 없는 경우
				numCount += 1;
			} else { 						// 산에 속한 소모임 있는 경우 임의 선택
				List<Integer> recommendedPiNumList = generateRecommendedNumList(piNumList, 3);
				recommendation.setPiNumList(recommendedPiNumList);
				numCount += recommendedPiNumList.size();
			}
			insertResult += recommendationMapper.insertRecommendedMountainAndPartys(recommendation);
		}

		if (insertResult != numCount) {
			throw new RuntimeException("저장 대상 개수와 저장 완료된 개수가 일치하지 않습니다.");
		}
		return recommendedMiNumList.size() >= 3 && insertResult == numCount;
	}

	// 파라미터로 받은 List에서 임의로 count만큼 숫자를 선택해 List로 저장
	private List<Integer> generateRecommendedNumList(List<Integer> numList, int count) {
		if (numList.size() <= count) {
			return numList;
		}

		Random random = new Random();
		List<Integer> recommendedNumList = new ArrayList<>();
		while (recommendedNumList.size() < count) {
			int recommendNum = numList.get(random.nextInt(numList.size()));
			if (!recommendedNumList.contains(recommendNum)) {
				recommendedNumList.add(recommendNum);
			}
		}
		return recommendedNumList;
	}
	
}
