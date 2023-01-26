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

import com.yummyclimbing.service.party.PartyBoardService;
import com.yummyclimbing.vo.party.PartyBoardVO;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class PartyBoardController {

	@Autowired
	private PartyBoardService partyBoardService;
	
	//소모임 게시글 리스트
	@GetMapping("/party-boards/{piNum}")
	@ResponseBody
	public List<PartyBoardVO> getPartyBoardList(PartyBoardVO partyBoard, @PathVariable("piNum") int piNum){
		partyBoard.setPiNum(piNum);
		return partyBoardService.selectPartyBoardList(partyBoard);
	}
	
	//소모임 게시판 게시글 선택해서 상세 정보불러오기
	@GetMapping("/party-boards/{piNum}/{pbNum}")
	@ResponseBody
	public PartyBoardVO getPartyBoard(PartyBoardVO partyBoard, @PathVariable("piNum") int piNum, @PathVariable("pbNum") int pbNum) {
		partyBoard.setPiNum(piNum);
		partyBoard.setPbNum(pbNum);
		return partyBoardService.selectPartyBoard(pbNum);
	}
	
	//소모임 게시판 게시글 등록
	@PostMapping("/party-boards/{piNum}")
	@ResponseBody
	public int insertPartyBoard(@RequestBody PartyBoardVO partyBoard, @PathVariable("piNum") int piNum, HttpSession session) {
		UserInfoVO sessionUserInfo = (UserInfoVO) session.getAttribute("userInfo");
		partyBoard.setUiNum(sessionUserInfo.getUiNum());
		partyBoard.setPiNum(piNum);
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
	
}
