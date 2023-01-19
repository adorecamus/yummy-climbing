package com.yummyclimbing.service.party;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyBoardMapper;
import com.yummyclimbing.mapper.party.PartyMemberMapper;
import com.yummyclimbing.vo.party.PartyMemberVO;

@Service
public class PartyMemberService {

	@Autowired
	private PartyMemberMapper partyMemberMapper;
	@Autowired
	private PartyBoardMapper partyBoardMapper;

	
	//소모임 회원 가입
	public int joinPartyMember(PartyMemberVO partyMember) {
		return partyMemberMapper.insertPartyMember(partyMember);
	}
	
	//소모임 회원 탈퇴-> 탈퇴한 회원이 작성한 글이 모두 삭제됨(비활성화)
	public int quitPartyMember(int uiNum) {
		partyMemberMapper.quitPartyMember(uiNum);
		return partyBoardMapper.updateQuitPartyBoardInactive(uiNum);
	}
	
	
	
}
