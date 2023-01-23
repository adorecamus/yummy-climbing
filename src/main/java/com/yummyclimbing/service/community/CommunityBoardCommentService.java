package com.yummyclimbing.service.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yummyclimbing.mapper.community.CommunityBoardCommentMapper;
import com.yummyclimbing.mapper.community.CommunityBoardMapper;
import com.yummyclimbing.vo.community.CommunityBoardCommentVO;

import lombok.Setter;

@Service
public class CommunityBoardCommentService {

	// 새로운 댓글이 추가되거나 삭제되면 
	//CommunityBoardMapper와 CommunityBoardCommentMapper를 같이 이용하여 처리
	@Setter(onMethod_ = @Autowired)
	private CommunityBoardCommentMapper cbcMapper;
	@Setter(onMethod_ = @Autowired)
	private CommunityBoardMapper cbMapper;	
	
	// 댓글 목록 조회 
	public List<CommunityBoardCommentVO> getCommentList(int cbNum){
		return cbcMapper.selectCommentList(cbNum);
	}
	
	// 댓글 등록
	@Transactional
	public int insertComment(CommunityBoardCommentVO cbcVO) {
		cbMapper.updateCommentCnt(cbcVO.getCbNum(), 1);
		return cbcMapper.insertComment(cbcVO);
	}
	
	// 댓글 수정
	public int updateComment(CommunityBoardCommentVO cbcVO) {
		return cbcMapper.updateComment(cbcVO);
	}
	
	// 댓글 삭제
	@Transactional
	public int deleteComment(int cbcNum) {
		CommunityBoardCommentVO cbcVO = cbcMapper.read(cbcNum);
		cbMapper.updateCommentCnt(cbcVO.getCbNum(), -1);
		return cbcMapper.updateCommentActive(cbcNum);
	}
	
}
