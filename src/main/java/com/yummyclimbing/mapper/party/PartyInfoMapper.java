package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyInfoVO;
import com.yummyclimbing.vo.party.PartyMemberVO;
import com.yummyclimbing.vo.user.UserInfoVO;

public interface PartyInfoMapper {

	List<PartyInfoVO> selectPartyInfoList(PartyInfoVO partyInfo);
	PartyInfoVO selectPartyInfo(int piNum);
	List<UserInfoVO> selectPartyMemberList(int piNum);
	PartyInfoVO selectCaptainNum(PartyInfoVO partyInfo);
	int insertPartyInfo(PartyInfoVO partyInfo);
	int updatePartyInfo(PartyInfoVO partyInfo);
	int updatePartyActive(PartyInfoVO partyInfo);
	int updatePartyActiveByExpdat(String piExpdat);
	
}
