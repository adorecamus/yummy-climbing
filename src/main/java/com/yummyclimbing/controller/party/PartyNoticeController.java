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

import com.yummyclimbing.service.party.PartyNoticeService;
import com.yummyclimbing.vo.party.PartyBoardNoticeVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class PartyNoticeController {

	@Autowired
	private PartyNoticeService partyBoardNoticeService;

	//소모임 공지 리스트
	@GetMapping("/party-notice/{piNum}")
	@ResponseBody
	public List<PartyBoardNoticeVO> getPartyNoticeList(PartyBoardNoticeVO partyBoardNotice, @PathVariable("piNum") int piNum){
		partyBoardNotice.setPiNum(piNum);
		return partyBoardNoticeService.selectPartyNoticeList(partyBoardNotice);

	}
	
	//소모임 공지사항 선택해서 상세 정보불러오기
	@GetMapping("/party-notice/{piNum}/{pbnNum}")
	@ResponseBody
	public PartyBoardNoticeVO getPartyNotice(@PathVariable("pbnNum") int pbnNum) {
		return partyBoardNoticeService.selectPartyNotice(pbnNum);
	}
	
	//소모임 공지사항 작성
	@PostMapping("/party-notice/{piNum}")
	@ResponseBody
	public int insertPartyBoardNotice(@RequestBody PartyBoardNoticeVO partyBoardNotice) {
		return partyBoardNoticeService.insertPartyNotice(partyBoardNotice);
	}
	
	//소모임 공지사항 수정
	@PatchMapping("/party-notice/{pbnNum}")
	@ResponseBody
	public int updatePartyNotice(@RequestBody PartyBoardNoticeVO partyBoardNotice, @PathVariable("pbnNum") int pbnNum) {
		partyBoardNotice.setPbnNum(pbnNum);
		return partyBoardNoticeService.updatePartyNotice(partyBoardNotice);
	}
	
	//소모임 공지사항 삭제(비활성화)
	@DeleteMapping("/party-boards/notice/{pbnNum}")
	@ResponseBody
	public int updatePartyNoticeActive(@RequestBody PartyBoardNoticeVO partyBoardNotice, @PathVariable("pbnNum") int pbnNum) {
		partyBoardNotice.setPbnNum(pbnNum);
		return partyBoardNoticeService.deletePartyNotice(pbnNum);
	}
}
