package com.yummyclimbing.controller.board;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.yummyclimbing.vo.board.BoardInfoVO;
import com.yummyclimbing.vo.board.BoardLikeVO;

@RestController
public class BoardInfoController {

//	@GetMapping("/board-info")
//	public String getBoardInfo(Model model, @ModelAttribute @RequestBody BoardInfoVO boardInfo, BoardLikeVO boardLike) {
//		model.addAttribute("boardInfo", boardInfoService.selectBoardInfo(boardInfo));
//		model.addAttribute("like", boardLikeService.searchLike(BoardLikeVO boardLike));
//		model.addAttribute("getLike", boardLikeService.getLike(BoardLikeVO boardLike));
//		//boardLikeService.hit(biLike);
//		
//	 return "views/board-info/view";
//	}
//	
}
