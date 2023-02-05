package com.yummyclimbing.service.mountain;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.mountain.MountainUserLikeMapper;
import com.yummyclimbing.mapper.user.UserInfoMapper;
import com.yummyclimbing.util.HttpSessionUtil;
import com.yummyclimbing.vo.mountain.MountainUserLikeVO;

@Service
public class MountainUserLikeService {
	
    //-----Dependency injection----///
	@Autowired
	private MountainUserLikeMapper mountainUserLikeMapper;
	
	@Autowired
	private UserInfoMapper userInfoMapper;
	
	// 활성화된 좋아요 갯수 가져오기
	public int getMountainUserLikeEnabledCount(MountainUserLikeVO mountainUserLike) {
		return mountainUserLikeMapper.getMountainUserLikeEnabledCount(mountainUserLike);
	}
	
	// 좋아요 정보 존재 체크
	public int checkMountainUserLikeInfo(MountainUserLikeVO mountainUserLike) throws RuntimeException{
		Integer sessionUiNum = HttpSessionUtil.getUserInfo().getUiNum();

		if(userInfoMapper.selectUserInfo(sessionUiNum)!=null && userInfoMapper.selectUserInfo(sessionUiNum).getUiActive()!=0) {
			if(mountainUserLikeMapper.checkMountainUserLikeInfo(mountainUserLike)!=null
					&& mountainUserLikeMapper.checkMountainUserLikeInfo(mountainUserLike).size()==1) {
				if(mountainUserLikeMapper.checkMountainUserLikeInfo(mountainUserLike).get(0).getMulCnt()==1) {
					return 1;
				}
			}
		}else {
			throw new RuntimeException("유저 정보 오류 발생");
		}
		return 0;
	}
	
	//좋아요 상태 변경(없으면 레코드 추가)
	public int setMountainUserLike(MountainUserLikeVO mountainUserLike) throws RuntimeException {
		Integer sessionUiNum = HttpSessionUtil.getUserInfo().getUiNum();

		if(userInfoMapper.selectUserInfo(sessionUiNum)!=null && userInfoMapper.selectUserInfo(sessionUiNum).getUiActive()!=0) {
			if(mountainUserLikeMapper.checkMountainUserLikeInfo(mountainUserLike)==null
					|| mountainUserLikeMapper.checkMountainUserLikeInfo(mountainUserLike).size()==0) {
				return mountainUserLikeMapper.insertMountainUserLike(mountainUserLike);
			}
			return mountainUserLikeMapper.toggleMountainUserLike(mountainUserLike);
		} else {
			throw new RuntimeException("유저 정보 오류 발생");
		}
	}
	
}
