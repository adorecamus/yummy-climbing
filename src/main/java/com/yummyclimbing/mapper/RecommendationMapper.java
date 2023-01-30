package com.yummyclimbing.mapper;

import java.util.List;

import com.yummyclimbing.vo.RecommendationVO;

public interface RecommendationMapper {

	int insertRecommendedMountainAndPartys(RecommendationVO recommendation);
	int selectCountForDuplicateVerification();
	List<Integer> selectRecommendedMiNumList();
	
}
