package com.yummyclimbing.mapper.community;

import java.util.List;

import com.yummyclimbing.vo.community.CommunityFileInfoVO;

public interface CommunityFileInfoMapper {

	List<CommunityFileInfoVO> selectFileList(int cbNum);

	int insertFile(CommunityFileInfoVO cfVO);
	
	int deleteFile(int cbNum);
}
