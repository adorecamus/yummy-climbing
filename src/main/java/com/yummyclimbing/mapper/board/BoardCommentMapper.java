package com.yummyclimbing.mapper.board;

import java.util.List;

import com.yummyclimbing.vo.board.BoardCommentVO;

public interface BoardCommentMapper {
	List<BoardCommentVO> commentList(int biNum);
	int totalComment(int biNum); // 댓글 수
	int insertComment(BoardCommentVO comment);
	int updateComment(BoardCommentVO comment);
//	int updateCommentActive(int biNum);
	int deleteComment(int bcNum);
//	List<BoardCommentVO> selectComment(int bcNum);
}
