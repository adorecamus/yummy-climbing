package com.yummyclimbing.service.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.board.BoardInfoMapper;
import com.yummyclimbing.vo.board.BoardInfoVO;

@Service
public class BoardInfoService {

	@Autowired
	private BoardInfoMapper boardInfoMapper;
	
	public List<BoardInfoVO> getBoardInfos(BoardInfoVO boardInfo) {
		return boardInfoMapper.selectBoardInfoList(boardInfo);
	}
	
	public int insertBoardInfo(BoardInfoVO boardInfo) {
		return boardInfoMapper.insertBoardInfo(boardInfo);
	}
	
	public BoardInfoVO getBoardInfo(int biNum) {
		return boardInfoMapper.selectBoardInfo(biNum);
	}

	public int updateBoardInfoActive(int biNum) {
		return boardInfoMapper.updateBoardInfoActive(biNum);
	}
	
	public int updateBoardInfo(BoardInfoVO boardInfo) {
		return boardInfoMapper.updateBoardInfo(boardInfo);
	}
}
