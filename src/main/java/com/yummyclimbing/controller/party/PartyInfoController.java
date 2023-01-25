package com.yummyclimbing.controller.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.anno.CheckAuth;
import com.yummyclimbing.service.party.PartyInfoService;
import com.yummyclimbing.vo.party.PartyInfoVO;
import com.yummyclimbing.vo.user.UserInfoVO;

@Controller
public class PartyInfoController {

	@Autowired
	private PartyInfoService partyInfoService;

	// 소모임 리스트
	@GetMapping("/party-infos")
	@ResponseBody
	public List<PartyInfoVO> getPartyList(PartyInfoVO partyInfo) {
		return partyInfoService.getPartyList(partyInfo);
	}
	
	// 추천 소모임 리스트
	@GetMapping("/party-infos/recommended")
	@ResponseBody
	public List<PartyInfoVO> getRecommendedPartyList(PartyInfoVO partyInfo) {
		return partyInfoService.getRecommendedPartyList(partyInfo);
	}

	// 개별 소모임 화면
	@GetMapping("/party-infos/{piNum}")
	@ResponseBody
	public PartyInfoVO getPartyInfo(@PathVariable("piNum") int piNum) {
		return partyInfoService.getPartyInfo(piNum);
	}

	// 개별 소모임 화면 - 멤버 정보 보기
	@GetMapping("/party-infos/{piNum}/members")
	@ResponseBody
	public List<UserInfoVO> getPartyMembers(@PathVariable("piNum") int piNum) {
		return partyInfoService.getPartyMembers(piNum);
	}

	// 소모임 생성
	@PostMapping("/party-infos")
	@ResponseBody
	@CheckAuth
	public boolean createParty(@RequestBody PartyInfoVO partyInfo) {
		return partyInfoService.createParty(partyInfo);
	}

	// 소모임 수정
	@PatchMapping("/party-infos/{piNum}")
	@ResponseBody
	public boolean updatePartyInfo(@RequestBody PartyInfoVO partyInfo, @PathVariable("piNum") int piNum) {
//		partyInfo.setUiNum(); //세션에 저장된 uiNum 가져오기?
		partyInfo.setPiNum(piNum);
		// piActive가 1이 아니면 수정할 수 없게 하는 로직 추가?
		return partyInfoService.updatePartyInfo(partyInfo);
	}

	// 소모임 삭제(비활성화)
	@DeleteMapping("/party-infos/{piNum}")
	@ResponseBody
	public boolean deletePartyInfo(@RequestBody PartyInfoVO partyInfo, @PathVariable("piNum") int piNum) {
//		partyInfo.setUiNum(); //세션에 저장된 uiNum 가져오기?
		return partyInfoService.deletePartyInfo(partyInfo);
	}

	// 소모임 모집완료
	@PatchMapping("/party-infos/complete/{piNum}")
	@ResponseBody
	public boolean completeParty(@RequestBody PartyInfoVO partyInfo, @PathVariable("piNum") int piNum) {
//		partyInfo.setUiNum(); //세션에 저장된 uiNum 가져오기?
		partyInfo.setPiNum(piNum);
		return partyInfoService.updatePartyInfo(partyInfo);
	}

}
