package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyMemberVO;

public interface PartyMemberMapper {

	boolean insertPartyMember(PartyMemberVO partyMember);
	int quitPartyMember(PartyMemberVO partyMember);
	List<PartyMemberVO> selectPiNumAndGradeByUiNum(int uiNum);
	PartyMemberVO checkJoinedParty(int uiNum);
	boolean rejoinParty(PartyMemberVO partyMember);
}
