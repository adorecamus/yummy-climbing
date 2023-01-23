package com.yummyclimbing.service.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyBoardCommentMapper;
import com.yummyclimbing.vo.party.PartyBoardCommentVO;

@Service
public class PartyBoardCommentService {

	@Autowired
	private PartyBoardCommentMapper partyBoardCommentMapper;
	
	//소모임 게시물 댓글
	public List<PartyBoardCommentVO> selectPartyBoardCommentList(PartyBoardCommentVO partyBoardComment){
		return partyBoardCommentMapper.selectPartyBoardCommentList(partyBoardComment);
	}
	
	//소모임 게시물 댓글 작성
	public int insertPartyBoardComment(PartyBoardCommentVO partyBoardComment) {
		return partyBoardCommentMapper.insertPartyBoardComment(partyBoardComment);
	}
	
	//소모임 게시물 댓글 수정
	public int updatePartyBoardComment(PartyBoardCommentVO partyBoardComment) {
		return partyBoardCommentMapper.updatePartyBoardComment(partyBoardComment);
	}
	
	//소모임 게시물 댓글 삭제
	public int updatePartyBoardCommentActive(int pbcNum) {
		return partyBoardCommentMapper.updatePartyBoardCommentActive(pbcNum);
	}
}
