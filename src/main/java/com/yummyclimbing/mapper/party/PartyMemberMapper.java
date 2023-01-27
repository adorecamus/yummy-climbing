package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyMemberVO;

public interface PartyMemberMapper {

	int insertPartyMember(PartyMemberVO partyMember);
	int quitPartyMember(int pmNum);
	List<PartyMemberVO> selectPartyAndGradeOfMember(int uiNum);
	
}
