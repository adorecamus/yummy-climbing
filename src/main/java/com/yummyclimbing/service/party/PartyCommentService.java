package com.yummyclimbing.service.party;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyCommentMapper;
import com.yummyclimbing.mapper.party.PartyMemberMapper;
import com.yummyclimbing.vo.party.PartyCommentVO;
import com.yummyclimbing.vo.user.UserInfoVO;

@Service
public class PartyCommentService {

	@Autowired
	private PartyCommentMapper partyCommentMapper;
	
	//소모임 소근소근 게시판 글 리스트 보기
	public List<PartyCommentVO> getPartyCommentList(PartyCommentVO partyComment, HttpSession session) {
		UserInfoVO sessionUserInfo = (UserInfoVO) session.getAttribute("userInfo");
		partyComment.setUiNum(sessionUserInfo.getUiNum());
		return partyCommentMapper.getPartyCommentList(partyComment);
	}
	
	//소모임 소근소근 게시판 글쓰기
	public int insertPartyComment(PartyCommentVO partyComment, HttpSession session) {
		UserInfoVO sessionUserInfo = (UserInfoVO) session.getAttribute("userInfo");
		partyComment.setUiNum(sessionUserInfo.getUiNum());
		return partyCommentMapper.insertPartyComment(partyComment);
	}
}
