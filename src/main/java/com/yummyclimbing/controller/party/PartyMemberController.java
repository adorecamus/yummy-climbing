package com.yummyclimbing.controller.party;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.yummyclimbing.service.party.PartyMemberService;

@Controller
public class PartyMemberController {

	@Autowired
	private PartyMemberService partyMemberService;
	
	

}
