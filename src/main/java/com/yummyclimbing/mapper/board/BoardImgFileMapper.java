package com.yummyclimbing.mapper.board;

import java.util.List;

import com.yummyclimbing.vo.board.BoardImgFileVO;

public interface BoardImgFileMapper {

	List<BoardImgFileVO> selectBoardImgFileList();
	int insertBoardImgFile(BoardImgFileVO boardImgFile);
}
