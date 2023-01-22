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

import com.yummyclimbing.service.party.PartyBoardService;
import com.yummyclimbing.vo.party.PartyBoardVO;

@Controller
public class PartyBoardController {

	@Autowired
	private PartyBoardService partyBoardService;
	
	//소모임 게시글 리스트
	@GetMapping("/party-boards")
	@ResponseBody
	public List<PartyBoardVO> getPartyBoardList(PartyBoardVO partyBoard){
		return partyBoardService.selectPartyBoardList(partyBoard);
	}
	
	//소모임 게시판 게시글 선택해서 상세 정보불러오기
	@GetMapping("/party-boards/{pbNum}")
	@ResponseBody
	public PartyBoardVO getPartyBoard(@PathVariable("pbNum") int pbNum) {
		return partyBoardService.selectPartyBoard(pbNum);
	}
	
	//소모임 게시판 게시글 등록
	@PostMapping("/party-boards")
	@ResponseBody
	public int insertPartyBoard(@RequestBody PartyBoardVO partyBoard) {
		return partyBoardService.insertPartyBoard(partyBoard);
	}
	
	//소모임 게시판 게시글 수정
	@PatchMapping("/party-boards/{pbNum}")
	@ResponseBody
	public int updatePartyBoard(@RequestBody PartyBoardVO partyBoard, @PathVariable("pbNum") int pbNum) {
		partyBoard.setPbNum(pbNum);
		return partyBoardService.updatePartyBoard(partyBoard);
	}
	
	//소모임 게시판 게시글 삭제(비활성화됨)
	@DeleteMapping("/party-boards/{pbNum}")
	@ResponseBody
	public int updatePartyBoardActive(@RequestBody PartyBoardVO partyBoard, @PathVariable("pbNum") int pbNum) {
		partyBoard.setPbNum(pbNum);
		return partyBoardService.deletePartyBoard(pbNum);
	}
	
	//소모임 공지게시판에 글작성(방장만 가능)
	@PostMapping("/party-boards/notice")
	@ResponseBody
	public int insertPartyBoardNotice(@RequestBody PartyBoardVO partyBoard) {
		return partyBoardService.insertPartyBoardNotice(partyBoard);
	}
}
