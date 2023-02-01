package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyInfoVO;
import com.yummyclimbing.vo.user.UserInfoVO;

public interface PartyInfoMapper {
	
	List<PartyInfoVO> selectPartyInfoList(PartyInfoVO partyInfo);
	List<PartyInfoVO> selectRecommendedPartyList(PartyInfoVO partyInfo);
	
	PartyInfoVO selectPartyInfo(int piNum);
	List<UserInfoVO> selectPartyMemberList(int piNum);
	
	PartyInfoVO selectCaptainNum(PartyInfoVO partyInfo);
	
	int insertPartyInfo(PartyInfoVO partyInfo);
	int updatePartyInfo(PartyInfoVO partyInfo);
	int updatePartyMemberActive(PartyInfoVO partyInfo);
	int updatePartyActive(PartyInfoVO partyInfo);
	int updatePartyComplete(PartyInfoVO partyInfo);
	
	int selectExpiredParty(String piExpdat);
	int updatePartyCompleteByExpdat(String piExpdat);
	
	List<Integer> selectPiNumListByMiNum(int miNum);
	
}
