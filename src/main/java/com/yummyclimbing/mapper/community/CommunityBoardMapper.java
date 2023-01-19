package com.yummyclimbing.mapper.community;

import java.util.List;

import com.yummyclimbing.vo.community.CommunityBoardVO;

public interface CommunityBoardMapper {

	List<CommunityBoardVO> selectCommunityBoardList(CommunityBoardVO communityBoard);
	CommunityBoardVO selectCommunityBoard(int cbNum);
	int insertCommunityBoard(CommunityBoardVO communityBoard);
	int updateCommunityBoardActive(int cbNum);
	int updateCommunityBoard(CommunityBoardVO communityBoard);
}
