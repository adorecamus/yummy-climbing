package com.yummyclimbing.service.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyInfoMapper;
import com.yummyclimbing.vo.party.PartyInfoVO;

@Service
public class PartyInfoService {

	@Autowired
	private PartyInfoMapper partyInfoMapper;
	
	public List<PartyInfoVO> selectPartyInfoList(PartyInfoVO partyInfo){
		return partyInfoMapper.selectPartyInfoList(partyInfo);
	}
	
	public PartyInfoVO selectPartyInfo(int piNum) {
		return partyInfoMapper.selectPartyInfo(piNum);
	}
	
	public int insertParty(PartyInfoVO partyInfo) {
		return partyInfoMapper.insertParty(partyInfo);
	}
	
	public int updatePartyInfo(PartyInfoVO partyInfo) {
		return partyInfoMapper.updatePartyInfo(partyInfo);
	}
	
	public int updatePartyActive(int piNum) {
		return partyInfoMapper.updatePartyActive(piNum);
	}
}
