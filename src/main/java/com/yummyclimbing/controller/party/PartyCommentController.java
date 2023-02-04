package com.yummyclimbing.controller.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
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
	public List<PartyCommentVO> getPartyCommentList(PartyCommentVO partyComment, @PathVariable("piNum")int piNum){
		partyComment.setPiNum(piNum);
		return partyCommentService.getPartyCommentList(partyComment);
	}
	
	@PostMapping("/party-comments/{piNum}")
	@ResponseBody
	public int insertPartyComment(@RequestBody PartyCommentVO partyComment, @PathVariable("piNum")int piNum) {
		partyComment.setPiNum(piNum);
		return partyCommentService.insertPartyComment(partyComment);
	}
	
	@PatchMapping("/party-comment/{pcNum}")
	@ResponseBody
	public int updatePartyComment(@RequestBody PartyCommentVO partyComment, @PathVariable("pcNum")int pcNum) {
		partyComment.setPcNum(pcNum);
		return partyCommentService.updatePartyComment(partyComment);
	}
	
	@DeleteMapping("/party-comment/{pcNum}")
	@ResponseBody
	public int deletePartyComment(@PathVariable("pcNum")int pcNum) {
		return partyCommentService.updatePartyCommentInactive(pcNum);
	}
	


}

	