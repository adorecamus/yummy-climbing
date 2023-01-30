package com.yummyclimbing.service.party;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyLikeMapper;
import com.yummyclimbing.vo.party.PartyLikeVO;

@Service
public class PartyLikeService {

	@Autowired
	private PartyLikeMapper partyLikeMapper;
	
	//좋아요 정보 가져오기

	
	//좋아요 등록
	public boolean likeUp(PartyLikeVO partyLike, HttpSession session) {
		if(partyLikeMapper.likeUp(partyLike) == 1) {
		
			
		}
		return false;
	}
	
	//좋아요 취소
	
	//좋아요 개수
}
