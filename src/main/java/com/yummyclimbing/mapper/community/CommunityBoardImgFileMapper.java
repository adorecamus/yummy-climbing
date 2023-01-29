package com.yummyclimbing.mapper.community;

import java.util.List;

import com.yummyclimbing.vo.community.CommunityBoardImgFileVO;

public interface CommunityBoardImgFileMapper {

	List<CommunityBoardImgFileVO> selectBoardImgFileList();
	int insertBoardImgFile(CommunityBoardImgFileVO boardImgFile);
}
