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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.party.PartyInfoService;
import com.yummyclimbing.vo.party.PartyInfoVO;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class PartyInfoController {

	@Autowired
	private PartyInfoService partyInfoService;

	// 소소모임 리스트
	@GetMapping("/party-infos")
	@ResponseBody
	public List<PartyInfoVO> getPartyList(PartyInfoVO partyInfo) {
		return partyInfoService.getPartyList(partyInfo);
	}
	
	// 추천 소소모임 리스트
	@GetMapping("/party-infos/recommended")
	@ResponseBody
	public List<PartyInfoVO> getRecommendedPartyList(PartyInfoVO partyInfo) {
		return partyInfoService.getRecommendedPartyList(partyInfo);
	}

	// 개별 소소모임 화면
	@GetMapping("/party-infos/{piNum}")
	@ResponseBody
	public PartyInfoVO getPartyInfo(@PathVariable("piNum") int piNum) {
		return partyInfoService.getPartyInfo(piNum);
	}

	// 소소모임 부원 리스트
	@GetMapping("/party-infos/members/{piNum}")
	@ResponseBody
	public List<UserInfoVO> getPartyMembers(@PathVariable("piNum") int piNum) {
		return partyInfoService.getPartyMembers(piNum);
	}

	// 소소모임 생성
	@PostMapping("/party-info")
	@ResponseBody
	public int createParty2(@RequestBody PartyInfoVO partyInfo) {
		return partyInfoService.createParty(partyInfo);
	}

	// 소소모임 수정
	@PatchMapping("/party-info/{piNum}")
	@ResponseBody
	public boolean updatePartyInfo(@RequestBody PartyInfoVO partyInfo, @PathVariable("piNum") int piNum) {
		return partyInfoService.updatePartyInfo(partyInfo, piNum);
	}
	
	// 소소모임 멤버 탈퇴/차단
	@PatchMapping("/party-info/members/{piNum}")
	@ResponseBody
	public int sendPartyMembersOut(@RequestBody PartyInfoVO partyInfo, @PathVariable("piNum") int piNum) {
		return partyInfoService.sendPartyMembersOut(partyInfo, piNum);
	}
	
	// 차단된 소소모임 부원 리스트
	@GetMapping("/party-info/members/blocked")
	@ResponseBody
	public List<UserInfoVO> getBlockedPartyMembers(@RequestParam("piNum") int piNum) {
		return partyInfoService.getBlockedPartyMembers(piNum);
	}

	// 소소모임 삭제(비활성화)
	@DeleteMapping("/party-info/{piNum}")
	@ResponseBody
	public boolean deletePartyInfo(@RequestBody PartyInfoVO partyInfo, @PathVariable("piNum") int piNum) {
		return partyInfoService.deletePartyInfo(piNum);
	}

	// 소소모임 모집완료
	@PatchMapping("/party-info/complete/{piNum}")
	@ResponseBody
	public boolean completeParty(@RequestBody PartyInfoVO partyInfo, @PathVariable("piNum") int piNum) {
		partyInfo.setPiNum(piNum);
		return partyInfoService.completeParty(piNum);
	}

	// 산에 속한 소소모임 리스트
	@GetMapping("/party-infos/mountain/{mntnm}")
	@ResponseBody
	public List<PartyInfoVO> getPartyInfosForMntnm(@PathVariable String mntnm){
		return partyInfoService.selectPartyInfoListForMntnm(mntnm);
	}

}
