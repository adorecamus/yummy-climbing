package com.yummyclimbing.controller.party;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.party.PartyNoticeService;
import com.yummyclimbing.vo.party.PartyNoticeVO;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class PartyNoticeController {

	@Autowired
	private PartyNoticeService partyNoticeService;

	//소모임 공지 리스트
	@GetMapping("/party-notice/{piNum}")
	@ResponseBody
	public List<PartyNoticeVO> getPartyNoticeList(PartyNoticeVO partyNotice, @PathVariable("piNum") int piNum){
		partyNotice.setPiNum(piNum);
		return partyNoticeService.selectPartyNoticeList(partyNotice);

	}
	
	//소모임 공지사항 선택해서 상세 정보불러오기
	@GetMapping("/party-notice/{piNum}/{pnNum}")
	@ResponseBody
	public PartyNoticeVO getPartyNotice(@PathVariable("pnNum") int pnNum) {
		return partyNoticeService.selectPartyNotice(pnNum);
	}
	
	//소모임 공지사항 작성
	@PostMapping("/party-notice/{piNum}")
	@ResponseBody
	public String insertPartyNotice(@RequestBody PartyNoticeVO partyNotice, @PathVariable("piNum") int piNum, HttpSession session) {
		UserInfoVO sessionUserInfo = (UserInfoVO) session.getAttribute("userInfo");
		partyNotice.setUiNum(sessionUserInfo.getUiNum());
		partyNotice.setPiNum(piNum);
		return partyNoticeService.insertPartyNotice(partyNotice);
	}
	
	//소모임 공지사항 수정
	@PatchMapping("/party-notice/{pnNum}")
	@ResponseBody
	public int updatePartyNotice(@RequestBody PartyNoticeVO partyNotice, @PathVariable("pnNum") int pnNum) {
		partyNotice.setPnNum(pnNum);
		return partyNoticeService.updatePartyNotice(partyNotice);
	}
	
	//소모임 공지사항 삭제(비활성화)
	@DeleteMapping("/party-notice/{pnNum}")
	@ResponseBody
	public int updatePartyNoticeActive(@PathVariable("pnNum") int pnNum) {
		return partyNoticeService.deletePartyNotice(pnNum);
	}
}
