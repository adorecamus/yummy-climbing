package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyMemberVO;

public interface PartyMemberMapper {

	boolean insertPartyMember(PartyMemberVO partyMember);
	int quitPartyMember(PartyMemberVO partyMember);
	List<PartyMemberVO> selectPiNumAndGradeByUiNum(int uiNum);
	PartyMemberVO checkJoinedParty(PartyMemberVO partyMember);
	boolean rejoinParty(PartyMemberVO partyMember);
	int PartyCaptinCheck(PartyMemberVO partyMember);
	PartyMemberVO selectMemberAuth(PartyMemberVO partyMember);

}
