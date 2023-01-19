package com.yummyclimbing.controller.party;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.yummyclimbing.service.party.PartyInfoService;

@Controller
public class PartyInfoController {

	@Autowired
	private PartyInfoService partyInfoService;
}
