package com.yummyclimbing.mapper.mountain;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yummyclimbing.vo.mountain.MountainItemVO;

public interface MountainInfoMapper {
	List<MountainItemVO> selectMountainInfoList(MountainItemVO mountainInfo);
	MountainItemVO selectMountainInfoByMntnm(String MNTNM);
	int insertMountainInfoList(@Param("mountainList") List<MountainItemVO> mountainList);
	int updateMountainInfoList(@Param("mountainList") List<MountainItemVO> mountainList);
	int updateMountainInfo(MountainItemVO mountainInfo);
	int deleteMountainInfoList();
	List<Integer> selectMiNumList();
	List<MountainItemVO> selectRecommendedMountainList();
}
