package com.yummyclimbing.mapper.community;

import java.util.List;

import com.yummyclimbing.vo.community.CommunityFileInfoVO;

public interface CommunityFileInfoMapper {

	List<CommunityFileInfoVO> selectFileList(int cbNum);
	
	CommunityFileInfoVO selectFileInfo(int cfNum);
	
	int insertFile(List<CommunityFileInfoVO> fileInfo);
	
	int deleteFile(int cbNum);
	
	int selectFileInfoTotalCnt(int cbNum);
}
