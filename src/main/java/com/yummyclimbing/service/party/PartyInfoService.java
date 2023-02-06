package com.yummyclimbing.service.party;

import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.Instant;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.exception.AuthException;
import com.yummyclimbing.mapper.party.PartyInfoMapper;
import com.yummyclimbing.mapper.party.PartyMemberMapper;
import com.yummyclimbing.util.HttpSessionUtil;
import com.yummyclimbing.vo.party.PartyInfoVO;
import com.yummyclimbing.vo.party.PartyMemberVO;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PartyInfoService {

	@Autowired
	private PartyInfoMapper partyInfoMapper;

	@Autowired
	private PartyMemberMapper partyMemberMapper;

	// 소소모임 리스트
	public List<PartyInfoVO> getPartyList(PartyInfoVO partyInfo) {
		return partyInfoMapper.selectPartyInfoList(partyInfo);
	}

	// 추천 소소모임 리스트
	public List<PartyInfoVO> getRecommendedPartyList(PartyInfoVO partyInfo) {
		return partyInfoMapper.selectRecommendedPartyList(partyInfo);
	}

	// 개별 소소모임 화면
	public PartyInfoVO getPartyInfo(int piNum) {
		return partyInfoMapper.selectPartyInfo(piNum);
	}

	// 개별 소소모임 화면 - 부원 정보 보기
	public List<UserInfoVO> getPartyMembers(int piNum) {
		return partyInfoMapper.selectPartyMemberList(piNum);
	}

	// 소소모임 생성
	public int createParty(PartyInfoVO partyInfo) {
		partyInfo.setUiNum(HttpSessionUtil.getUserInfo().getUiNum());
		if (partyInfoMapper.insertPartyInfo(partyInfo) == 1) { 	// 소소모임 insert 성공한 경우
			PartyMemberVO captain = new PartyMemberVO(); 		// 대장을 PARTY_MEMBER 테이블에 등록하기 위해
			int piNum = partyInfo.getPiNum();					// insert한 소소모임num 가져옴
			captain.setPiNum(piNum);
			captain.setUiNum(partyInfo.getUiNum());
			captain.setPmGrade(1);
			if (partyMemberMapper.insertPartyMember(captain)) { // 대장을 PARTY_MEMBER 테이블에 insert
				return piNum;									// 생성된 소모임num 리턴
			}
		}
		return 0;
	}

	// 소소모임 수정
	public boolean updatePartyInfo(PartyInfoVO partyInfo, int piNum) {
		partyInfo.setPiNum(piNum);
		return partyInfoMapper.updatePartyInfo(partyInfo) == 1;
	}
	
	// 소소모임 부원 탈퇴/차단/차단 해제
	public int changePartyMemberStatus(PartyInfoVO partyInfo, int piNum){
		int uiNum = HttpSessionUtil.getUserInfo().getUiNum();
		if (partyInfo.getPmNums().contains(uiNum)) {
			throw new AuthException("대장은 내보낼 수 없습니다.");
		}
		partyInfo.setPiNum(piNum);
		return partyInfoMapper.updatePartyMemberActive(partyInfo);
	}
	
	// 차단한 소소모임 부원 리스트
	public List<UserInfoVO> getBlockedPartyMembers(int piNum) {
		return partyInfoMapper.selectBlockedPartyMemberList(piNum);
	}

	// 소소모임 삭제(비활성화)
	public boolean deletePartyInfo(int piNum) {
		return partyInfoMapper.updatePartyActive(piNum) == 1;
	}

	// 소소모임 수동 모집완료
	public boolean completeParty(int piNum) {
		return partyInfoMapper.updatePartyComplete(piNum) == 1;
	}
	
	// 부원 수와 정원 비교해서 모집완료 상태 변경
	public void changePartyCompleteStatus(int piNum) {
		partyInfoMapper.updatePartyCompleteByMemberCount(piNum);
	}

	// 모집기한 만료 소소모임 자동 모집완료
	public boolean completePartyByExpdat() {
		// 오늘 날짜가 만료일인 소소모임을 모집완료로 변경
		Date date = Date.from(Instant.now().minus(Duration.ofDays(1)));
		String today = new SimpleDateFormat("yyyyMMdd").format(date);
		int partyCount = partyInfoMapper.selectExpiredParty(today);
		log.debug("partyCount=>{}", partyCount);
		int completeResult = partyInfoMapper.updatePartyCompleteByExpdat(today);
		log.debug("completeResult=>{}", completeResult);
		if (partyCount != completeResult) {
			throw new RuntimeException("완료 대상 모임 개수와 완료 실행 개수가 일치하지 않습니다.");
		}
		return partyCount == completeResult;
	}
	
	// 소소모임 대장 여부 확인
	public void checkCaptainAuth() {
		PartyInfoVO captain = new PartyInfoVO();
		captain.setUiNum(HttpSessionUtil.getUserInfo().getUiNum());
		captain.setPiNum(Integer.parseInt(HttpSessionUtil.getRequest().getParameter("piNum")));
		if (partyInfoMapper.selectCaptainNum(captain) == null) {
			log.debug("~~~~~~~~~어라 방장 아니구만~~~~~~~~~~");
			throw new AuthException("대장 권한이 없습니다.");
		}
	}
	
	// 산별 소소모임 리스트
	public List<PartyInfoVO> selectPartyInfoListForMntnm(String mntnm){		
		return partyInfoMapper.selectPartyInfoListForMntnm(mntnm);
	}

}
