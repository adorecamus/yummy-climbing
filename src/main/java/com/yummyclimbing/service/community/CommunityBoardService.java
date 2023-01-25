package com.yummyclimbing.service.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.community.CommunityBoardMapper;
import com.yummyclimbing.vo.community.CommunityBoardVO;
import com.yummyclimbing.vo.community.Criteria;

@Service
public class CommunityBoardService {

	@Autowired
	private CommunityBoardMapper communityBoardMapper;
	
	// 게시판 목록 조회 
	public List<CommunityBoardVO> getBoardList(CommunityBoardVO communityBoard){
		return communityBoardMapper.selectCommunityBoardList(communityBoard);
	}
	
	// 게시판 목록 페이징
	public List<CommunityBoardVO> getListPaging(Criteria cri) {
		return communityBoardMapper.selectListPaging(cri);
	}
	
	// 게시물 조회
	public CommunityBoardVO getBoard(int cbNum) {
		return communityBoardMapper.selectCommunityBoard(cbNum);
	}
	
	// 게시물 등록
	public int insertBoard(CommunityBoardVO communityBoard) {
		return communityBoardMapper.insertCommunityBoard(communityBoard);
	}
	
	// 게시물 삭제 
	public int updateBoardActive(int cbNum) {
		return communityBoardMapper.updateCommunityBoardActive(cbNum);
	}
	
	// 게시물 수정
	public int updateBoard(CommunityBoardVO communityBoard) {
		return communityBoardMapper.updateCommunityBoard(communityBoard);
	}
	
	// 게시물 조회수
	public int updateViewCnt(int cbNum) {
		return communityBoardMapper.updateViewCnt(cbNum);
	}
	
	// 게시물 총 개수 
	public int getTotal() {
		return communityBoardMapper.getTotal();
	}
	
}
