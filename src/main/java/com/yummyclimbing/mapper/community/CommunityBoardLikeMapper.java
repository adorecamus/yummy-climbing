package com.yummyclimbing.mapper.community;

import com.yummyclimbing.vo.community.CommunityBoardLikeVO;

public interface CommunityBoardLikeMapper {

	// 좋아요 확인(눌렀는지 안 눌렀는지)
	int likeCnt(CommunityBoardLikeVO cbl);
	
	// 좋아요 정보
	CommunityBoardLikeVO getLikeInfo(CommunityBoardLikeVO cbl);
	
	// 좋아요 등록
	int likeUp(CommunityBoardLikeVO cbl);
	
	// 좋아요 취소
	int likeDown(CommunityBoardLikeVO cbl);
	
	void updateLikeChk(CommunityBoardLikeVO cbl);
	
	void updateLikeChkCancel(CommunityBoardLikeVO cbl);
}
