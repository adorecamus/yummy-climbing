package com.yummyclimbing.service.mountain;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.mountain.MountainCommentMapper;
import com.yummyclimbing.vo.mountain.MountainCommentVO;

@Service
public class MountainCommentService {

	@Autowired
	MountainCommentMapper mountainCommentMapper;
	
	public List<MountainCommentVO> selectMountainCommentListAndUser(int miNum){
		return mountainCommentMapper.selectMountainCommentListAndUser(miNum);
	}
	
	public int insertMountainComment(MountainCommentVO MountainComment) {
		return mountainCommentMapper.insertMountainComment(MountainComment);
	}
}
