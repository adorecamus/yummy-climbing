package com.yummyclimbing.service.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyCommentMapper;
import com.yummyclimbing.util.HttpSessionUtil;
import com.yummyclimbing.vo.party.PartyCommentVO;

@Service
public class PartyCommentService {

	@Autowired
	private PartyCommentMapper partyCommentMapper;
	
	//소모임 소근소근 게시판 글 리스트 보기
	public List<PartyCommentVO> getPartyCommentList(int piNum) {
		return partyCommentMapper.getPartyCommentList(piNum);
	}
	
	//소모임 소근소근 게시판 글쓰기
	public int insertPartyComment(PartyCommentVO partyComment, int piNum) {
		partyComment.setPiNum(piNum);
		partyComment.setUiNum(HttpSessionUtil.getUserInfo().getUiNum());
		return partyCommentMapper.insertPartyComment(partyComment);
	}

	//소근소근 글 수정
	public int updatePartyComment(PartyCommentVO partyComment) {
		int sessionUiNum = HttpSessionUtil.getUserInfo().getUiNum();
		partyComment.setUiNum(sessionUiNum);
		return partyCommentMapper.updatePartyComment(partyComment);
	}
	
	//소근소근 글 삭제
	public int updatePartyCommentInactive(int pcNum) {
		return partyCommentMapper.updatePartyCommentInactive(pcNum);
	}

	
}
