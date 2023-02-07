package com.yummyclimbing.service.community;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.yummyclimbing.mapper.community.CommunityBoardMapper;
import com.yummyclimbing.mapper.community.CommunityFileInfoMapper;
import com.yummyclimbing.util.HttpSessionUtil;
import com.yummyclimbing.vo.community.CommunityBoardVO;
import com.yummyclimbing.vo.community.CommunityFileInfoVO;
import com.yummyclimbing.vo.community.Criteria;

@Service
public class CommunityBoardService {

	@Autowired
	private CommunityBoardMapper communityBoardMapper;
	
	// 게시판 목록 조회 
	public List<CommunityBoardVO> getBoardList(CommunityBoardVO communityBoard){
		return communityBoardMapper.selectCommunityBoardList(communityBoard);
	}
	
	// 게시판 카테고리별 조회
	public List<CommunityBoardVO> getBoardListByCategory(CommunityBoardVO communityBoard) {
		return communityBoardMapper.selectCommunityBoardListByCategory(communityBoard);
	}
	
	// 게시판 목록 페이징
	public List<CommunityBoardVO> getListPaging(Criteria cri) {
		return communityBoardMapper.selectListWithPage(cri);
	}
	
	public int getTotalCnt(Criteria cri) {
		return communityBoardMapper.getTotalCnt(cri);
	}
	
	// 게시글 조회
	public CommunityBoardVO getBoard(int cbNum) {
		return communityBoardMapper.selectCommunityBoard(cbNum);
	}
	
	// 게시글 등록
	public int insertBoard(CommunityBoardVO communityBoard) {
		communityBoard.setUiNum(HttpSessionUtil.getUserInfo().getUiNum());
		return communityBoardMapper.insertCommunityBoard(communityBoard);
	}
	
	// 게시글 삭제 
	public int deleteBoard(int cbNum) {
		return communityBoardMapper.deleteCommunityBoard(cbNum);
	}
	
	// 게시글 수정
	public int updateBoard(CommunityBoardVO communityBoard) {
		return communityBoardMapper.updateCommunityBoard(communityBoard);
	}
	
	// 게시글 조회수
	public int updateViewCnt(int cbNum) {
		return communityBoardMapper.updateViewCnt(cbNum);
	}
	
	// 게시글 총 개수 
	public int getTotal() {
		return communityBoardMapper.getTotal();
	}
	
}
