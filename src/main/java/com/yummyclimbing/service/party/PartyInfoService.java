package com.yummyclimbing.service.party;

import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyInfoMapper;
import com.yummyclimbing.mapper.party.PartyMemberMapper;
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

	// 개별 소모임 화면
	public PartyInfoVO getPartyInfo(int piNum) {
		return partyInfoMapper.selectPartyInfo(piNum);
	}

	// 개별 소모임 화면 - 멤버 정보 보기
	public List<UserInfoVO> getPartyMembers(int piNum) {
		return partyInfoMapper.selectPartyMemberList(piNum);
	}

	// 소모임 생성
	public boolean createParty(PartyInfoVO partyInfo) {
		if (partyInfoMapper.insertPartyInfo(partyInfo) == 1) {
			PartyMemberVO captain = new PartyMemberVO();
			captain.setPiNum(partyInfo.getPiNum());
			captain.setUiNum(partyInfo.getUiNum());
			return partyMemberMapper.insertPartyMember(captain) == 1; // 소모임 생성과 함께 방장을 멤버 테이블에 등록
		}
		return false;
	}

	// 소모임 수정
	public boolean updatePartyInfo(PartyInfoVO partyInfo) {
		if (partyInfoMapper.selectCaptainNum(partyInfo) == null) {
			return false;
		}
		return partyInfoMapper.updatePartyInfo(partyInfo) == 1;
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
