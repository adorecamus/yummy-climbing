package com.yummyclimbing.mapper.mountain;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yummyclimbing.vo.mountain.MountainInfoItemVO;
import com.yummyclimbing.vo.mountain.MountainSearchVO;

public interface MountainInfoMapper {
	List<MountainInfoItemVO> selectMountainInfoList(MountainInfoItemVO mountainInfo);
	MountainInfoItemVO selectMountainInfoByMntnm(String mntnm);
	int insertMountainInfoList(@Param("mountainList") List<MountainInfoItemVO> mountainList);
	int insertMountainInfo(MountainInfoItemVO mountainList);
	int updateMountainInfoList(@Param("mountainList") List<MountainInfoItemVO> mountainList);
	int updateMountainInfo(MountainInfoItemVO mountainInfo);
	int deleteMountainInfoList();
	List<Integer> selectMiNumList();
	List<MountainInfoItemVO> selectRecommendedMountainList();
	List<MountainSearchVO> selectMountainNameAndArea(MountainSearchVO mountainSearch);
}
