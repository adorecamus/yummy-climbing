package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyCommentVO;

public interface PartyCommentMapper {

	List<PartyCommentVO> getPartyCommentList(PartyCommentVO partyComment);
	
}
