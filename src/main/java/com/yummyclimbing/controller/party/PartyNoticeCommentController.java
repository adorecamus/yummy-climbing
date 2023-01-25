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

import com.yummyclimbing.service.party.PartyNoticeCommentService;
import com.yummyclimbing.vo.party.PartyNoticeCommentVO;

@Controller
public class PartyNoticeCommentController {

	@Autowired
	private PartyNoticeCommentService partyNoticeCommentService;
	
	//공지게시판
		//소모임 공지 댓글 리스트
		@GetMapping("/party-boards/{pbnNum}/comments")
		@ResponseBody
		public List<PartyNoticeCommentVO> getPartyNoticeCommentList(PartyNoticeCommentVO partyNoticeComment, @PathVariable("pbnNum") int pbnNum){
			partyNoticeComment.setPbnNum(pbnNum);
			return partyNoticeCommentService.selectPartyNoticeCommentList(partyNoticeComment);
		}
		
		//소모임 공지 댓글 작성
		@PostMapping("/party-boards/{pbnNum}/comments")
		@ResponseBody
		public int insertPartyNoticeComment(@RequestBody PartyNoticeCommentVO partyNoticeComment, @PathVariable("pbnNum") int pbnNum) {
			partyNoticeComment.setPbnNum(pbnNum);
			return partyNoticeCommentService.insertPartyNoticeComment(partyNoticeComment);
		}
		
		//소모임 공지 댓글 수정
		@PatchMapping("/party-boards/{pbnNum}/{pncNum}")
		@ResponseBody
		public int updatePartyNoticeComment(@RequestBody PartyNoticeCommentVO partyNoticeComment, @PathVariable("pbnNum") int pbnNum, @PathVariable("pncNum") int pncNum) {
			partyNoticeComment.setPbnNum(pbnNum);
			partyNoticeComment.setPncNum(pncNum);
			return partyNoticeCommentService.updatePartyNoticeComment(partyNoticeComment);
		}
		
		//소모임 공지 댓글 삭제
		@DeleteMapping("/party-boards/{pbnNum}/{pncNum}")
		@ResponseBody
		public int updatePartyNoticeCommentActive(@RequestBody PartyNoticeCommentVO partyNoticeComment,@PathVariable("pbnNum") int pbnNum, @PathVariable("pncNum") int pncNum) {
			partyNoticeComment.setPbnNum(pbnNum);
			partyNoticeComment.setPncNum(pncNum);
			return partyNoticeCommentService.updatePartyNoticeCommentActive(pncNum);
		}
}
