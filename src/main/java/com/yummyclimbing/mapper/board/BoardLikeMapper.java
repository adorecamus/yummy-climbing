package com.yummyclimbing.mapper.board;

import com.yummyclimbing.vo.board.BoardLikeVO;

public interface BoardLikeMapper {

	int searchLike(BoardLikeVO boardLike);
	int likeUp(BoardLikeVO boardLike);
	int likeDown(BoardLikeVO boardLike);
}
