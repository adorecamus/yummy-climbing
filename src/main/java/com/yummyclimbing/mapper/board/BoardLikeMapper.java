package com.yummyclimbing.mapper.board;

import com.yummyclimbing.vo.board.BoardLikeVO;

public interface BoardLikeMapper {

	int searchLike(BoardLikeVO boardLike); //좋아요 눌렀는지 확인
	int likeUp(BoardLikeVO boardLike); // 좋아요 등록
	int likeDown(BoardLikeVO boardLike); // 좋아요 취소
}
