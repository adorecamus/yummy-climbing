package com.yummyclimbing.controller.board;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.yummyclimbing.service.board.BoardCommentService;
import com.yummyclimbing.vo.board.BoardCommentVO;
import com.yummyclimbing.vo.user.UserInfoVO;

@RestController
public class BoardCommentController {

	@Autowired
	private BoardCommentService boardCommentService;

	// 댓글 목록 조회
	@GetMapping("/comments/{biNum}")
	@ResponseBody
	public List<BoardCommentVO> getComments(@PathVariable int biNum) {
		List<BoardCommentVO> list = boardCommentService.commentList(biNum);
		return list;
	}

	// 댓글 등록 
	@PostMapping("/comments") 
	@ResponseBody
	public int insertComment(@RequestBody BoardCommentVO comment, HttpSession session) {
		UserInfoVO userInfo = (UserInfoVO) session.getAttribute("userInfo");
		if(userInfo == null) {
			throw new RuntimeException("로그인이 필요한 서비스입니다.");
		}
		comment.setUiNum(userInfo.getUiNum());
		return boardCommentService.insertComment(comment);
	}
	
	// 댓글 수정 
	@PatchMapping("/comments/{biNum}")
	@ResponseBody
	public int updateComment(@RequestBody BoardCommentVO comment, @PathVariable int biNum) {
		comment.setBiNum(biNum);
		return boardCommentService.updateComment(comment);
	}
	
	//댓글 삭제
	@DeleteMapping("/comments/{bcNum}")
	@ResponseBody
	public int deleteComment(@PathVariable int bcNum) {
		return boardCommentService.deleteComment(bcNum);
	}

}
