package com.yummyclimbing.service.mountain;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.mountain.MountainUserLikeMapper;
import com.yummyclimbing.vo.mountain.MountainUserLikeVO;

@Service
public class MountainUserLikeService {
	
    //-----Dependency injection----///
	@Autowired
	private MountainUserLikeMapper mountainUserLikeMapper;
	
	// 활성화된 좋아요 갯수 가져오기
	public int getMountainUserLikeEnabledCount(MountainUserLikeVO mountainUserLike) {
		return mountainUserLikeMapper.getMountainUserLikeEnabledCount(mountainUserLike);
	}
	
	// 좋아요 정보 존재 체크
	public boolean checkMountainUserLikeInfo(MountainUserLikeVO mountainUserLike){
		if(mountainUserLikeMapper.checkMountainUserLikeInfo(mountainUserLike)!=null) {
			return true;
		}
		return false;
	}
	
	public int insertMountainUserLike(MountainUserLikeVO mountainUserLike) {
		return mountainUserLikeMapper.insertMountainUserLike(mountainUserLike);
	}
	
	public int toggleMountainUserLike(MountainUserLikeVO mountainUserLike) {
		return mountainUserLikeMapper.toggleMountainUserLike(mountainUserLike);
	}
	
}
