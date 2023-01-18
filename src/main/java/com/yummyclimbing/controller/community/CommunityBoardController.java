package com.yummyclimbing.controller.community;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.community.CommunityBoardService;
import com.yummyclimbing.vo.community.CommunityBoardVO;
import com.yummyclimbing.vo.user.UserInfoVO;

@Controller
public class CommunityBoardController {

	@Autowired
	private CommunityBoardService communityBoardService;
	
	//게시판 목록 
	@GetMapping("/community-board")
	@ResponseBody
	public List<CommunityBoardVO> getBoardList(@ModelAttribute CommunityBoardVO communityBoard) {
		return communityBoardService.getBoardList(communityBoard);
	}
	
	//게시글 
	@GetMapping("/community-board/{cbNum}")
	@ResponseBody
	public CommunityBoardVO getBoard(@PathVariable int cbNum) {
		return communityBoardService.getBoard(cbNum);
	}
	
	@PostMapping("/community-board")
	@ResponseBody
	public int insertBoard(@RequestBody CommunityBoardVO communityBoard, HttpSession session) {
		UserInfoVO userInfo = (UserInfoVO)session.getAttribute("userInfo");
		if(userInfo == null) {
			throw new RuntimeException("로그인 후 이용 바랍니다. ");
		}
		communityBoard.setUiNum(userInfo.getUiNum());
		return communityBoardService.insertBoard(communityBoard);
	}
	
	@PatchMapping("/community-board/{cbNum}")
	@ResponseBody
	public int updateBoard(@RequestBody CommunityBoardVO communityBoard, @PathVariable int cbNum) {
		communityBoard.setCbNum(cbNum);
		return communityBoardService.updateBoard(communityBoard);
	}
	
	@DeleteMapping("/community-board/{cbNum}")
	@ResponseBody
	public int deleteBoard(@PathVariable int cbNum) {
		return communityBoardService.updateBoardActive(cbNum);
	}
	
}
