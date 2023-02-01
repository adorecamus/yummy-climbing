package com.yummyclimbing.service.party;

import java.text.SimpleDateFormat;
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

	// 소모임 리스트
	public List<PartyInfoVO> getPartyList(PartyInfoVO partyInfo) {
		return partyInfoMapper.selectPartyInfoList(partyInfo);
	}

	// 추천 소모임 리스트
	public List<PartyInfoVO> getRecommendedPartyList(PartyInfoVO partyInfo) {
		return partyInfoMapper.selectRecommendedPartyList(partyInfo);
	}

	// 개별 소모임 화면
	public PartyInfoVO getPartyInfo(int piNum) {
		return partyInfoMapper.selectPartyInfo(piNum);
	}

	// 개별 소모임 화면 - 멤버 정보 보기
	public List<UserInfoVO> getPartyMembers(int piNum) {
		return partyInfoMapper.selectPartyMemberList(piNum);
	}

	// 소모임 생성
	public int createParty(PartyInfoVO partyInfo) {
		partyInfo.setUiNum(HttpSessionUtil.getUserInfo().getUiNum());
		if (partyInfoMapper.insertPartyInfo(partyInfo) == 1) { 	// 소모임 insert 성공한 경우
			PartyMemberVO captain = new PartyMemberVO(); 		// 방장을 멤버 테이블에 등록하기 위해
			int piNum = partyInfo.getPiNum();					// insert한 소모임num 가져옴
			captain.setPiNum(piNum);
			captain.setUiNum(partyInfo.getUiNum());
			captain.setPmGrade(1);
			if (partyMemberMapper.insertPartyMember(captain)) { // 멤버 테이블에 insert
				return piNum;									// 생성된 소모임num 리턴
			}
		}
		return 0;
	}

	// 소모임 수정
	public boolean updatePartyInfo(PartyInfoVO partyInfo, int piNum) {
		partyInfo.setPiNum(piNum);
		partyInfo.setUiNum(HttpSessionUtil.getUserInfo().getUiNum());
		return partyInfoMapper.updatePartyInfo(partyInfo) == 1;
	}
	
	// 소모임 회원 관리
	public int sendPartyMembersOut(PartyInfoVO partyInfo, int piNum){
		int uiNum = HttpSessionUtil.getUserInfo().getUiNum();
		if (partyInfo.getPmNums().contains(uiNum)) {
			throw new AuthException("방장은 내보낼 수 없습니다.");
		}
		partyInfo.setPiNum(piNum);
		partyInfo.setUiNum(uiNum);
		return partyInfoMapper.updatePartyMemberActive(partyInfo);
	}

	// 소모임 삭제(비활성화)
	public boolean deletePartyInfo(PartyInfoVO partyInfo) {
		if (partyInfoMapper.selectCaptainNum(partyInfo) == null) {
			return false;
		}
		return partyInfoMapper.updatePartyActive(partyInfo) == 1;
	}

	// 소모임 수동 모집완료
	public boolean completeParty(PartyInfoVO partyInfo) {
		if (partyInfoMapper.selectCaptainNum(partyInfo) == null) {
			return false;
		}
		return partyInfoMapper.updatePartyComplete(partyInfo) == 1;
	}

	// 모집기한 만료 소모임 자동 모집완료
	public boolean completePartyByExpdat() {
		// 오늘 날짜가 만료일인 소모임을 모집완료로 변경
		Instant now = Instant.now();
		Date date = Date.from(now);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today = sdf.format(date);
		int partyCount = partyInfoMapper.selectExpiredParty(today);
		log.debug("partyCount=>{}", partyCount);
		int completeResult = partyInfoMapper.updatePartyCompleteByExpdat(today);
		log.debug("completeResult=>{}", completeResult);
		if (partyCount != completeResult) {
			throw new RuntimeException("완료 대상 모임 개수와 완료 실행 개수가 일치하지 않습니다.");
		}
		return partyCount == completeResult;
	}

}
