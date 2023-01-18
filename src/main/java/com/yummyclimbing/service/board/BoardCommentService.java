package com.yummyclimbing.service.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.board.BoardCommentMapper;
import com.yummyclimbing.vo.board.BoardCommentVO;

@Service
public class BoardCommentService {

	@Autowired
	private BoardCommentMapper boardCommentMapper;
	
	public List<BoardCommentVO> commentList(int biNum) {
		return boardCommentMapper.commentList(biNum);
	}
	
	public int getTotalComment(int biNum) {
		return boardCommentMapper.getTotalComment(biNum);
	}
	
	public int insertComment(BoardCommentVO comment) {
		return boardCommentMapper.insertComment(comment);
	}
	
	public int updateComment(BoardCommentVO comment) {
		return boardCommentMapper.updateComment(comment);
	}
	
	public int updateCommentActive(int biNum) {
		return boardCommentMapper.updateCommentActive(biNum);
	}
	
	public int deleteComment(BoardCommentVO comment) {
		return boardCommentMapper.deleteComment(comment);
	}
	
	public List<BoardCommentVO> selectComment(int bcNum) {
		return boardCommentMapper.selectComment(bcNum);
	}
}
