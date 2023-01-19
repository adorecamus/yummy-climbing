package com.yummyclimbing.controller.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.yummyclimbing.service.party.PartyInfoService;
import com.yummyclimbing.vo.party.PartyInfoVO;

@Controller
public class PartyInfoController {

	@Autowired
	private PartyInfoService partyInfoService;
	
	//소모임 리스트
	public List<PartyInfoVO> getPartyList(PartyInfoVO partyInfo){
		return partyInfoService.getPartyList(partyInfo);
	}
	
	//개별 소모임 화면
	public PartyInfoVO getPartyInfo(int piNum) {
		return partyInfoService.getPartyInfo(piNum);
	}
	
	//소모임 생성
	public boolean insertParty(PartyInfoVO partyInfo) {
		return partyInfoService.insertParty(partyInfo);
	}
	
	//소모임 수정
	public boolean updatePartyInfo(PartyInfoVO partyInfo) {
		return partyInfoService.updatePartyInfo(partyInfo);
	}
	
	//소모임 삭제(비활성화)
	public boolean updatePartyActive(PartyInfoVO partyInfo) {
		return partyInfoService.updatePartyActive(partyInfo);
	}
	
}
