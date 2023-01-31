package com.yummyclimbing.controller.party;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.party.PartyCommentService;
import com.yummyclimbing.vo.party.PartyCommentVO;

@Controller
public class PartyCommentController {

	@Autowired
	private PartyCommentService partyCommentService;
	
	@GetMapping("/party-comments/{piNum}")
	@ResponseBody
	public List<PartyCommentVO> getPartyCommentList(PartyCommentVO partyComment, HttpSession session, @PathVariable("piNum")int piNum){
		partyComment.setPiNum(piNum);
		return partyCommentService.getPartyCommentList(partyComment, session);
	}
	
	@PostMapping("/party-comments/{piNum}")
	@ResponseBody
	public int insertPartyComment(@RequestBody PartyCommentVO partyComment, HttpSession session, @PathVariable("piNum")int piNum) {
		partyComment.setPiNum(piNum);
		return partyCommentService.insertPartyComment(partyComment, session);
	}
}

	