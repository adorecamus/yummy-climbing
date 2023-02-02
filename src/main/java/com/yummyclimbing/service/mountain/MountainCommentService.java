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
	
	
	//산 번호로 검색한 코멘트리스트
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
	
	//댓글 수정
	public int updateMountainComment(MountainCommentVO mountainComment) throws Exception {
		int sessionUiNum = HttpSessionUtil.getUserInfo().getUiNum();
		
		if(userInfoMapper.selectUserInfo(sessionUiNum)!=null && userInfoMapper.selectUserInfo(sessionUiNum).getUiActive()!=0
				&& mountainComment.getUiNum()==sessionUiNum) { // session check
			return mountainCommentMapper.updateMountainComment(mountainComment);
		} else {
			throw new Exception("유저 정보 오류 발생");
		}		
	}
	
	//코멘트 삭제(비활성화)
	public int deleteMountainComment(MountainCommentVO mountainComment) throws Exception {
		int sessionUiNum = HttpSessionUtil.getUserInfo().getUiNum();
		
		if(userInfoMapper.selectUserInfo(sessionUiNum)!=null && userInfoMapper.selectUserInfo(sessionUiNum).getUiActive()!=0
				&& mountainComment.getUiNum()==sessionUiNum) { // session check
			return mountainCommentMapper.updateMountainCommentActive(mountainComment);
		} else {
			throw new Exception("유저 정보 오류 발생");
		}		
		
	}
}
