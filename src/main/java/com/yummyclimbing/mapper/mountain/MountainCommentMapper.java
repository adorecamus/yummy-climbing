package com.yummyclimbing.mapper.mountain;

import java.util.List;

import com.yummyclimbing.vo.mountain.MountainCommentVO;

public interface MountainCommentMapper {
	List<MountainCommentVO> selectMountainCommentList(MountainCommentVO MountainComment);
	List<MountainCommentVO> selectMountainCommentListAndUser(int miNum);
	int selectMountainCommentCount(MountainCommentVO MountainComment);
	int insertMountainComment(MountainCommentVO MountainComment);
	int updateMountainComment(MountainCommentVO MountainComment);
	int updateMountainCommentActive(MountainCommentVO MountainComment);
}
