package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyInfoVO;

public interface PartyInfoMapper {

	List<PartyInfoVO> selectPartyInfoList(PartyInfoVO partyInfo);
	PartyInfoVO selectPartyInfo(int piNum);
	int insertParty(PartyInfoVO partyInfo);
	int updatePartyInfo(PartyInfoVO partyInfo);
	int updatePartyActive(int piNum);
	
}
