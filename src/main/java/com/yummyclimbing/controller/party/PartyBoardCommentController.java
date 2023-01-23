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

import com.yummyclimbing.service.party.PartyBoardCommentService;
import com.yummyclimbing.vo.party.PartyBoardCommentVO;

@Controller
public class PartyBoardCommentController {

	@Autowired
	private PartyBoardCommentService partyBoardCommentService;
	
	//소모임 게시물 댓글
	@GetMapping("/party-board-comments")
	@ResponseBody
	public List<PartyBoardCommentVO> getPartyBoardCommentList(PartyBoardCommentVO partyBoardComment){
		return partyBoardCommentService.selectPartyBoardCommentList(partyBoardComment);
	}
	
	//소모임 게시물 댓글 작성
	@PostMapping("/party-board-comments")
	@ResponseBody
	public int insertPartyBoardComment(@RequestBody PartyBoardCommentVO partyBoardComment) {
		return partyBoardCommentService.insertPartyBoardComment(partyBoardComment);
	}
	
	//소모임 게시물 댓글 수정
	@PatchMapping("/party-board-comments/{pbcNum}")
	@ResponseBody
	public int updateBoardComment(@RequestBody PartyBoardCommentVO partyBoardComment, @PathVariable("pbcNum") int pbcNum) {
		partyBoardComment.setPbcNum(pbcNum);
		return partyBoardCommentService.updatePartyBoardComment(partyBoardComment);
	}
	
	//소모임 게시물 댓글 삭제
	@DeleteMapping("/party-board-comments/{pbcNum}")
	@ResponseBody
	public int updateBoardCommentActive(@RequestBody PartyBoardCommentVO partyBoardComment, @PathVariable("pbcNum") int pbcNum) {
		partyBoardComment.setPbcNum(pbcNum);
		return partyBoardCommentService.updatePartyBoardCommentActive(pbcNum);
	}
}
