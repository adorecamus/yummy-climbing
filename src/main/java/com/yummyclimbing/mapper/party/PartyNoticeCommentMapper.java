package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyNoticeCommentVO;

public interface PartyNoticeCommentMapper {

	//공지 댓글
	List<PartyNoticeCommentVO> selectPartyNoticeCommentList(PartyNoticeCommentVO partyNoticeComment);
	int insertPartyNoticeComment(PartyNoticeCommentVO partyNoticeComment);
	int updatePartyNoticeComment(PartyNoticeCommentVO partyNoticeComment);
	int updatePartyNoticeCommentActive(int pncNum);
}
