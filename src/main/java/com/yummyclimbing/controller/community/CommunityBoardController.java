package com.yummyclimbing.controller.community;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.yummyclimbing.service.community.CommunityBoardService;
import com.yummyclimbing.vo.community.CommunityBoardPageVO;
import com.yummyclimbing.vo.community.CommunityBoardVO;
import com.yummyclimbing.vo.community.Criteria;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CommunityBoardController {

	@Autowired
	private CommunityBoardService communityBoardService;
	
	// 게시판 목록 조회
	@GetMapping("/community-board")
	@ResponseBody
	public List<CommunityBoardVO> getBoardList(@ModelAttribute CommunityBoardVO communityBoard) {
		return communityBoardService.getBoardList(communityBoard);
	}
	
	// 게시판 목록 페이징
	@GetMapping("/community-board-pages")
	public void getBoardListPage(Model model, Criteria cri) {
		model.addAttribute("list", communityBoardService.getListPaging(cri));
		int total = communityBoardService.getTotal();
		CommunityBoardPageVO pageMake = new CommunityBoardPageVO(cri, total);
		model.addAttribute("pageMaker", pageMake);
	}
	
	// 게시글 조회
	@GetMapping("/community-board/{cbNum}")
	@ResponseBody
	public CommunityBoardVO getBoard(@PathVariable int cbNum) {
		communityBoardService.updateViewCnt(cbNum);
		return communityBoardService.getBoard(cbNum);
	}
	
	// 게시글 등록
	@PostMapping("/community-board")
	@ResponseBody
	public int insertBoard(@RequestBody CommunityBoardVO communityBoard, HttpSession session, MultipartFile[] files) throws Exception {
		UserInfoVO userInfo = (UserInfoVO)session.getAttribute("userInfo");
		if(userInfo == null) { 
			throw new RuntimeException("로그인 후 이용 바랍니다. ");
		}
		communityBoard.setUiNum(userInfo.getUiNum()); 
		return communityBoardService.insertBoard(communityBoard);
	}
	
	// 게시글 수정
	@PatchMapping("/community-board/{cbNum}")
	@ResponseBody
	public int updateBoard(@RequestBody CommunityBoardVO communityBoard, @PathVariable int cbNum) {
		communityBoard.setCbNum(cbNum);
		return communityBoardService.updateBoard(communityBoard);
	}
	
	// 게시글 삭제 
	@DeleteMapping("/community-board/{cbNum}")
	@ResponseBody
	public int deleteBoard(@PathVariable int cbNum) {
		return communityBoardService.deleteBoard(cbNum);
	}
	
}
