package com.yummyclimbing.service.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.community.CommunityBoardMapper;
import com.yummyclimbing.vo.community.CommunityBoardVO;

@Service
public class CommunityBoardService {

	@Autowired
	private CommunityBoardMapper communityBoardMapper;
	
	public List<CommunityBoardVO> getBoardList(CommunityBoardVO communityBoard){
		return communityBoardMapper.selectCommunityBoardList(communityBoard);
	}
	
	public CommunityBoardVO getBoard(int cbNum) {
		return communityBoardMapper.selectCommunityBoard(cbNum);
	}
	
	public int insertBoard(CommunityBoardVO communityBoard) {
		return communityBoardMapper.insertCommunityBoard(communityBoard);
	}
	
	public int updateBoardActive(int cbNum) {
		return communityBoardMapper.updateCommunityBoardActive(cbNum);
	}
	
	public int updateBoard(CommunityBoardVO communityBoard) {
		return communityBoardMapper.updateCommunityBoard(communityBoard);
	}
	
}
