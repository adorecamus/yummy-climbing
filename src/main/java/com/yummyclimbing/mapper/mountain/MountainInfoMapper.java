package com.yummyclimbing.mapper.mountain;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yummyclimbing.vo.mountain.MountainItemVO;

public interface MountainInfoMapper {
	List<MountainItemVO> selectMountainInfoList();
	int insertMountainInfoList(@Param("mountainList") List<MountainItemVO> mountainList);
	int deleteMountainInfoList();
}
