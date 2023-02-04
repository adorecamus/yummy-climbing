package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyInfoVO;
import com.yummyclimbing.vo.user.UserInfoVO;

public interface PartyInfoMapper {
	
	List<PartyInfoVO> selectPartyInfoList(PartyInfoVO partyInfo);			// 소소모임 리스트
	List<PartyInfoVO> selectRecommendedPartyList(PartyInfoVO partyInfo);	// 추천 소소모임 리스트
	PartyInfoVO selectPartyInfo(int piNum);									// 개별 소소모임 정보
	
	//	회원만 가능
	List<UserInfoVO> selectPartyMemberList(int piNum);						// 소소모임 부원 리스트
	int insertPartyInfo(PartyInfoVO partyInfo);								// 소소모임 생성
	
	//	소소모임 대장만 가능
	int updatePartyInfo(PartyInfoVO partyInfo);								// 소소모임 정보 수정
	int updatePartyMemberActive(PartyInfoVO partyInfo);						// 소소모임 부원 내보내기, 차단
	List<UserInfoVO> selectBlockedPartyMemberList(PartyInfoVO partyInfo);	// 소소모임 차단된 부원 리스트
	int updatePartyActive(PartyInfoVO partyInfo);							// 소소모임 삭제(비활성화)
	int updatePartyComplete(PartyInfoVO partyInfo);							// 소소모임 모집완료
	
	PartyInfoVO selectCaptainNum(PartyInfoVO partyInfo);					// 소소모임 대장 여부 확인
	
	int selectExpiredParty(String piExpdat);								// 만료 소소모임 개수
	int updatePartyCompleteByExpdat(String piExpdat);						// 만료일로 소소모임 자동 모집완료
	
	List<Integer> selectPiNumListByMiNum(int miNum);						// 산에 속한 소소모임 리스트
	
	List<PartyInfoVO> selectPartyInfoListForMntnm(String mntnm); // 산별 소소모임 리스트
	
}
