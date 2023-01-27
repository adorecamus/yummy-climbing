package com.yummyclimbing.service.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyNoticeCommentMapper;
import com.yummyclimbing.vo.party.PartyNoticeCommentVO;

@Service
public class PartyNoticeCommentService {

	@Autowired
	private PartyNoticeCommentMapper partyNoticeCommentMapper;
	
	//공지사항
	//소모임 공지 댓글
	public List<PartyNoticeCommentVO> selectPartyNoticeCommentList(PartyNoticeCommentVO partyNoticeComment){
		return partyNoticeCommentMapper.selectPartyNoticeCommentList(partyNoticeComment);
	}
	
	//소모임 공지 댓글 작성
	public int insertPartyNoticeComment(PartyNoticeCommentVO partyNoticeComment) {
		return partyNoticeCommentMapper.insertPartyNoticeComment(partyNoticeComment);
	}
	
	//소모임 공지 댓글 수정
	public int updatePartyNoticeComment(PartyNoticeCommentVO partyNoticeComment) {
		return partyNoticeCommentMapper.updatePartyNoticeComment(partyNoticeComment);
	}
	
	//소모임 공지 댓글 삭제
	public int updatePartyNoticeCommentActive(int pbcNum) {
		return partyNoticeCommentMapper.updatePartyNoticeCommentActive(pbcNum);
	}
	
}
