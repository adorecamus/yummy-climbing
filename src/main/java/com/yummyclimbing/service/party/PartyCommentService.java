package com.yummyclimbing.service.party;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyCommentMapper;
import com.yummyclimbing.vo.party.PartyCommentVO;
import com.yummyclimbing.vo.user.UserInfoVO;

@Service
public class PartyCommentService {

	@Autowired
	private PartyCommentMapper partyCommentMapper;
	
	public List<PartyCommentVO> getPartyCommentList(PartyCommentVO partyComment, HttpSession session) {
		UserInfoVO sessionUserInfo = (UserInfoVO) session.getAttribute("userInfo");
		partyComment.setUiNum(sessionUserInfo.getUiNum());
		return partyCommentMapper.getPartyCommentList(partyComment);
	}
}
