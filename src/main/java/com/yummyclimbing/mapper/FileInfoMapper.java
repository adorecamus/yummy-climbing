package com.yummyclimbing.mapper;

import java.util.List;

import com.yummyclimbing.vo.FileInfoVO;

public interface FileInfoMapper {
	List<FileInfoVO> selectFileInfoList();
	int insertFileInfo(FileInfoVO fileInfo);
}
