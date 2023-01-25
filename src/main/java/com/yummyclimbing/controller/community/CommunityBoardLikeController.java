package com.yummyclimbing.controller.community;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.community.CommunityBoardLikeService;
import com.yummyclimbing.vo.community.CommunityBoardLikeVO;

@Controller
public class CommunityBoardLikeController {

	@Autowired
	private CommunityBoardLikeService cblService;
	
	@GetMapping("/board-like")
	@ResponseBody
	public CommunityBoardLikeVO likeCnt(CommunityBoardLikeVO cbl) {
			return cblService.getLikeInfo(cbl);
		}
		
		/*
		 * int cbLike = 0; int check = cblService.likeCnt(cbl); if(check == 0) {
		 * cblService.likeUp(cbl); } else if(check == 1) { cbLike =
		 * cblService.getLikeInfo(cbl); } model.addAttribute("cbLike", cbLike);
		 */
	
	
	@PostMapping("/board-like")
	@ResponseBody
	public int updateLike(@RequestBody CommunityBoardLikeVO cbl) {
		int likeChk = cblService.likeCnt(cbl);
		if(likeChk == 0) {
			cblService.likeUp(cbl);
			cblService.updateLikeChk(cbl);
		} else if (likeChk == 1) {
			cblService.updateLikeChkCancel(cbl);
			cblService.likeDown(cbl);
		}
		return likeChk;
	}
	
}
