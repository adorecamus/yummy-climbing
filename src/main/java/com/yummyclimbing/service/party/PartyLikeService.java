package com.yummyclimbing.service.party;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyLikeMapper;
import com.yummyclimbing.util.HttpSessionUtil;
import com.yummyclimbing.vo.party.PartyLikeVO;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PartyLikeService {

	@Autowired
	private PartyLikeMapper partyLikeMapper;

	//좋아요 정보 가져오기
	public PartyLikeVO getLikeInfo(PartyLikeVO partyLike) {
		UserInfoVO sessionUserInfo = HttpSessionUtil.getUserInfo();
		partyLike.setUiNum(sessionUserInfo.getUiNum());
		return partyLikeMapper.getLikeInfo(partyLike);
	}
	
	//좋아요 개수 확인
	public int countPartyLike(PartyLikeVO partyLike) {
		return partyLikeMapper.likeCnt(partyLike);
	}
	
	//좋아요 정보 존재 체크
	public int checkPartyLike(PartyLikeVO partyLike) {
		UserInfoVO sessionUserInfo = HttpSessionUtil.getUserInfo();
		partyLike.setUiNum(sessionUserInfo.getUiNum());
		if(partyLikeMapper.likeCheck(partyLike) != null && partyLikeMapper.likeCheck(partyLike).size()==1) {
			if(partyLikeMapper.likeCheck(partyLike).get(0).getPlActive()== 1) {
				return 1;		
			}
		}
		return 0;
	}
	
	//좋아요 등록
	public int likeUp(PartyLikeVO partyLike) {
		UserInfoVO sessionUserInfo = HttpSessionUtil.getUserInfo();
		partyLike.setUiNum(sessionUserInfo.getUiNum());
		if(partyLikeMapper.likeCheck(partyLike) == null || partyLikeMapper.likeCheck(partyLike).size()==0) {
			return partyLikeMapper.likeUp(partyLike);
		}
		return partyLikeMapper.likeDown(partyLike);
	}
}
	

