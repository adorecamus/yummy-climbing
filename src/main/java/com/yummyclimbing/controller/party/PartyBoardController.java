package com.yummyclimbing.controller.party;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.yummyclimbing.service.party.PartyBoardService;

@Controller
public class PartyBoardController {

	@Autowired
	private PartyBoardService partyBoardService;
}
