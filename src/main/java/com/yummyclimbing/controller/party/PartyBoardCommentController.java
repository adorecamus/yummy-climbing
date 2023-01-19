package com.yummyclimbing.controller.party;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.yummyclimbing.service.party.PartyBoardCommentService;

@Controller
public class PartyBoardCommentController {

	@Autowired
	private PartyBoardCommentService partyBoardCommentService;
}
