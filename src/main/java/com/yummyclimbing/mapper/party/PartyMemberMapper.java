package com.yummyclimbing.mapper.party;

import com.yummyclimbing.vo.party.PartyMemberVO;

public interface PartyMemberMapper {

	int insertPartyMember(PartyMemberVO partyMember);
	int quitPartyMember(int pmNum);
	PartyMemberVO checkPartyMember(int uiNum);
}
