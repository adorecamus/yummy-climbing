package com.yummyclimbing.controller.community;

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

import com.yummyclimbing.service.community.CommunityBoardCommentService;
import com.yummyclimbing.vo.community.CommunityBoardCommentVO;
import com.yummyclimbing.vo.user.UserInfoVO;

@Controller
public class CommunityBoardCommentController {

	@Autowired
	private CommunityBoardCommentService cbcService;

	// 댓글 목록 조회
	@GetMapping("/community-comments/{cbNum}")
	@ResponseBody
	public List<CommunityBoardCommentVO> getCommentList(@PathVariable("cbNum") int cbNum) {
//		model.addAttribute("commentList", cbcService.getCommentList(cbNum));
		return cbcService.getCommentList(cbNum);
	}

	// 댓글 등록
	@PostMapping("/community-comments")
	@ResponseBody
	public int insertComment(@RequestBody CommunityBoardCommentVO cbcVO, HttpSession session) {
		UserInfoVO userInfo = (UserInfoVO) session.getAttribute("userInfo");
		if (userInfo == null) {
			throw new RuntimeException("댓글을 작성하려면 로그인 해주세요.");
		}
		cbcVO.setUiNum(userInfo.getUiNum());
		return cbcService.insertComment(cbcVO);
	}

	// 댓글 수정
	@PatchMapping("/community-comments/{cbcNum}")
	@ResponseBody 
	public int updateComment(@RequestBody CommunityBoardCommentVO cbcVO, @PathVariable("cbcNum")int cbcNum) { 
		cbcVO.setCbcNum(cbcNum);
		return cbcService.updateComment(cbcVO);
	}

	// 댓글 삭제
	// "Request method 'DELETE' not supported" 오류 발생 -> yml에 delete방식 사용 명시
	@DeleteMapping("/community-comments/{cbcNum}")
	@ResponseBody
	public int deleteComment(@PathVariable("cbcNum") int cbcNum) {
		return cbcService.deleteComment(cbcNum);
	}

}
