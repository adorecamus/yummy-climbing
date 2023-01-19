package com.yummyclimbing.service.party;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyBoardCommentMapper;

@Service
public class PartyBoardCommentService {

	@Autowired
	private PartyBoardCommentMapper partyBoardCommentMapper;
}
