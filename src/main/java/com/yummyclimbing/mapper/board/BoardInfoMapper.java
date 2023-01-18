package com.yummyclimbing.mapper.board;

import java.util.List;

import com.yummyclimbing.vo.board.BoardInfoVO;

public interface BoardInfoMapper {

	List<BoardInfoVO> selectBoardInfoList(BoardInfoVO boardInfo);
	BoardInfoVO selectBoardInfo(int biNum);
	int insertBoardInfo(BoardInfoVO boardInfo);
	int updateBoardInfoActive(int biNum);
	int updateBoardInfo(BoardInfoVO boardInfo);
}
