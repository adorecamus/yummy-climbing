package com.yummyclimbing.controller.community;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.community.CommunityBoardLikeService;
import com.yummyclimbing.vo.community.CommunityBoardLikeVO;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CommunityBoardLikeController {

	@Autowired
	private CommunityBoardLikeService cblService;
	
	@GetMapping("/board-like/{cbNum}")
	@ResponseBody
	public CommunityBoardLikeVO likeChk(CommunityBoardLikeVO cbl, HttpSession session) {
		UserInfoVO userInfo = (UserInfoVO)session.getAttribute("userInfo");
		if(userInfo == null) { 
			log.debug("userinfo=>{}", userInfo);
			throw new RuntimeException("로그인이 필요한 서비스입니다.");
		}
		cbl.setUiNum(userInfo.getUiNum());
		return cblService.getLikeInfo(cbl);
		}
	
	@PostMapping("/board-like")
	@ResponseBody
	public int updateLike(@RequestBody CommunityBoardLikeVO cbl) {
		int likeChk = cblService.likeChk(cbl);
		if(likeChk == 0) {
			cblService.likeUp(cbl);
			cblService.updateLikeChk(cbl);
		} else if (likeChk == 1) {
			cblService.updateLikeChkCancel(cbl);
			cblService.likeDown(cbl);
		}
		return likeChk;
	}
	
	@GetMapping("board-like-cnt/{cbNum}")
	@ResponseBody
	public int likeCnt(@PathVariable int cbNum, Model model) {
//		model.addAttribute("likeCnt", cblService.likeCnt(cbNum));
		return cblService.likeCnt(cbNum);
	}

}
