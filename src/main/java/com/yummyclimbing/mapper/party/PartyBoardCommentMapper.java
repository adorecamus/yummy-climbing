package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyBoardCommentVO;

public interface PartyBoardCommentMapper {

	List<PartyBoardCommentVO> selectPartyBoardCommentList(PartyBoardCommentVO partyBoardComment);
	int insertPartyBoardComment(PartyBoardCommentVO partyBoardComment);
	int updatePartyBoardComment(PartyBoardCommentVO partyBoardComment);
	int updatePartyBoardCommentActive(int pbcNum);
	
}
