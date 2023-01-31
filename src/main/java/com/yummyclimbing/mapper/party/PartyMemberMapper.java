package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyMemberVO;

public interface PartyMemberMapper {

	boolean insertPartyMember(PartyMemberVO partyMember);
	int quitPartyMember(int uiNum);
	List<PartyMemberVO> selectPartyAndGradeOfMember(int uiNum);
	PartyMemberVO checkJoinedParty(int uiNum);
	
}
