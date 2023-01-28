package com.yummyclimbing.service.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyMemberMapper;
import com.yummyclimbing.vo.party.PartyMemberVO;

@Service
public class PartyMemberService {

	@Autowired
	private PartyMemberMapper partyMemberMapper;

	//소모임 회원 가입
	public int joinPartyMember(PartyMemberVO partyMember) {
		return partyMemberMapper.insertPartyMember(partyMember);
	}
	
	//소모임 회원 탈퇴(비활성화)
	public int quitPartyMember(int uiNum) {
		return partyMemberMapper.quitPartyMember(uiNum);
	}
	
	// 로그인시 세션에 파티 멤버 정보 저장
	public List<PartyMemberVO> getPartyMemberInfo(int uiNum) {
		return partyMemberMapper.selectPartyAndGradeOfMember(uiNum);
	}
	
}
