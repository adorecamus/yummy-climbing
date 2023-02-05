package com.yummyclimbing.mapper.party;

import com.yummyclimbing.vo.party.PartyMemberVO;

public interface PartyMemberMapper {

	boolean insertPartyMember(PartyMemberVO partyMember);		// 소소모임 부원 가입
	int quitPartyMember(PartyMemberVO partyMember);				// 소소모임 부원 탈퇴
	int rejoinParty(PartyMemberVO partyMember);					// 탈퇴한 부원 재가입
	PartyMemberVO selectMemberAuth(PartyMemberVO partyMember);	// 소소모임 권한(대장/부원) 확인

}
