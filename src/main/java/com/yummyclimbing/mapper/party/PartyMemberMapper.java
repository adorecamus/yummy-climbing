package com.yummyclimbing.mapper.party;

import com.yummyclimbing.vo.party.PartyMemberVO;

public interface PartyMemberMapper {

	PartyMemberVO selectMemberCount(int piNum);
	boolean insertPartyMember(PartyMemberVO partyMember);		// 소소모임 부원 가입
	int quitPartyMember(PartyMemberVO partyMember);				// 소소모임 부원 탈퇴
	int rejoinParty(PartyMemberVO partyMember);					// 탈퇴한 부원 재가입
	PartyMemberVO selectMemberAuth(PartyMemberVO partyMember);	// 소소모임 권한(대장/부원) 확인

	boolean deleteLinkedMember(int uiNum);						//계정탈퇴 시 가입한 소소모임 자동탈퇴
}
