package com.yummyclimbing.service.mountain;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.mountain.MountainCommentMapper;
import com.yummyclimbing.mapper.mountain.MountainInfoMapper;
import com.yummyclimbing.mapper.user.UserInfoMapper;
import com.yummyclimbing.util.HttpSessionUtil;
import com.yummyclimbing.vo.mountain.MountainCommentVO;

@Service
public class MountainCommentService {

	@Autowired
	private MountainCommentMapper mountainCommentMapper;
	@Autowired
	private UserInfoMapper userInfoMapper;
	
	
	public List<MountainCommentVO> selectMountainCommentListAndUser(int miNum){
		return mountainCommentMapper.selectMountainCommentListAndUser(miNum);
	}
	
	public int insertMountainComment(MountainCommentVO mountainComment) throws Exception {
		int sessionUiNum = HttpSessionUtil.getUserInfo().getUiNum();
		
		if(userInfoMapper.selectUserInfo(sessionUiNum)!=null && userInfoMapper.selectUserInfo(sessionUiNum).getUiActive()!=0
				&& mountainComment.getUiNum()==sessionUiNum) {
			return mountainCommentMapper.insertMountainComment(mountainComment);
		} else {
			throw new Exception("유저 정보 오류 발생");
		}
	}
	
	public int deleteMountainComment(MountainCommentVO mountainComment) throws Exception {
		int sessionUiNum = HttpSessionUtil.getUserInfo().getUiNum();
		
		if(userInfoMapper.selectUserInfo(sessionUiNum)!=null && userInfoMapper.selectUserInfo(sessionUiNum).getUiActive()!=0
				&& mountainComment.getUiNum()==sessionUiNum) {
			return mountainCommentMapper.updateMountainCommentActive(mountainComment);
		} else {
			throw new Exception("유저 정보 오류 발생");
		}		
		
	}
}
