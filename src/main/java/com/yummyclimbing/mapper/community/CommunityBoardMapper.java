package com.yummyclimbing.mapper.community;

import java.util.List;

import org.springframework.data.repository.query.Param;

import com.yummyclimbing.vo.community.CommunityBoardVO;

public interface CommunityBoardMapper {

	List<CommunityBoardVO> selectCommunityBoardList(CommunityBoardVO communityBoard);
	CommunityBoardVO selectCommunityBoard(int cbNum);
	int insertCommunityBoard(CommunityBoardVO communityBoard);
	int updateCommunityBoardActive(int cbNum);
	int updateCommunityBoard(CommunityBoardVO communityBoard);
	
	// 해당 게시물 번호에 증가나 감소를 의미하는 amount 변수에 파라미터를 받을 수 있도록 처리 -> 댓글이 등록되면 1증가, 삭제되면 1감소 
	void updateCommentCnt(@Param("cbNum") int cbNum, @Param("amount") int amount);
}
