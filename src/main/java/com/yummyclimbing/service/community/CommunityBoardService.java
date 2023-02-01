package com.yummyclimbing.service.community;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.yummyclimbing.mapper.community.CommunityBoardMapper;
import com.yummyclimbing.mapper.community.CommunityFileInfoMapper;
import com.yummyclimbing.util.MultiFileUtils;
import com.yummyclimbing.vo.community.CommunityBoardVO;
import com.yummyclimbing.vo.community.CommunityFileInfoVO;
import com.yummyclimbing.vo.community.Criteria;

@Service
public class CommunityBoardService {

	@Autowired
	private CommunityBoardMapper communityBoardMapper;
	@Autowired
	private CommunityFileInfoMapper communityFileInfoMapper;
	@Autowired
	private MultiFileUtils multiFileUtils;
	
	// 게시판 목록 조회 
	public List<CommunityBoardVO> getBoardList(CommunityBoardVO communityBoard){
		return communityBoardMapper.selectCommunityBoardList(communityBoard);
	}
	
	// 게시판 목록 페이징
	public List<CommunityBoardVO> getListPaging(Criteria cri) {
		return communityBoardMapper.selectListPaging(cri);
	}
	
	// 게시글 조회
	public CommunityBoardVO getBoard(int cbNum) {
		return communityBoardMapper.selectCommunityBoard(cbNum);
	}
	
	// 게시글 등록
	public int insertBoard(CommunityBoardVO communityBoard) {
		return communityBoardMapper.insertCommunityBoard(communityBoard);
	}
	
	// 게시글 파일 업로드
	public boolean insertBoard(CommunityBoardVO communityBoard, MultipartFile[] files) {
		int result = 1;
		// 기존 게시글 등록 메소드 호출하여 게시글이 등록되었다면  
		if(insertBoard(communityBoard)== 0) {
			return false;
		}
		// 파일과 게시글 번호를 받아서 파일 업로드를 요청하고 multiFileUtils 클래스에서 파일 업로드 수행
		List<CommunityFileInfoVO> fileList = multiFileUtils.uploadFiles(files, communityBoard.getCbNum());
		
		// 리스트가 비어있지 않으면 communityFileInfoMapper의 파일등록 메소드를 호출하여 데이터베이스에 파일 정보 저장
		if(CollectionUtils.isEmpty(fileList) == false) {
			result = communityFileInfoMapper.insertFile(fileList);
			if(result < 1) {
				result = 0;
			}
		}
		return (result == 1);
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
