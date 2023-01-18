package com.yummyclimbing.controller.board;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
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

	@GetMapping("/comments/{biNum}")
	@ResponseBody
	public List<BoardCommentVO> getComments(@PathVariable int biNum, Model model) {
		List<BoardCommentVO> list = boardCommentService.commentList(biNum);
		return list;
	}

	@PostMapping("/comments")
	@ResponseBody
	public int insertComment(@RequestBody BoardCommentVO comment, HttpSession session) {
		UserInfoVO userInfo = (UserInfoVO) session.getAttribute("userInfo");
		if(userInfo == null) {
			throw new RuntimeException("로그인 후 작성 바랍니다.");
		}
		comment.setUiNum(userInfo.getUiNum());
		return boardCommentService.insertComment(comment);
	}
	
	/* @PatchMapping("/comments/{bcNum}") */
	
	@DeleteMapping("/comments/{bcNum}")
	@ResponseBody
	public int deleteComment(@PathVariable int bcNum) {
		return boardCommentService.updateCommentActive(bcNum);
	}

}
