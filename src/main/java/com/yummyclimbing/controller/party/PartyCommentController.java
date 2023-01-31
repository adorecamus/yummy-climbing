package com.yummyclimbing.controller.party;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.party.PartyCommentService;
import com.yummyclimbing.vo.party.PartyCommentVO;

@Controller
public class PartyCommentController {

	@Autowired
	private PartyCommentService partyCommentService;
	
	@GetMapping("/party-notice/comments")
	@ResponseBody
	public List<PartyCommentVO> getPartyCommentList(PartyCommentVO partyComment, HttpSession session){
		return partyCommentService.getPartyCommentList(partyComment, session);
	}
}
