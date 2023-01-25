package com.yummyclimbing.service.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyBoardMapper;
import com.yummyclimbing.mapper.party.PartyInfoMapper;
import com.yummyclimbing.vo.party.PartyBoardVO;
import com.yummyclimbing.vo.party.PartyInfoVO;

@Service
public class PartyBoardService {

	@Autowired
	private PartyBoardMapper partyBoardMapper;
	@Autowired
	private PartyInfoMapper partyInfoMapper;
	
	//소모임 일반 게시판(모든 소모임회원 가능) 
	//소모임 게시판 게시글 리스트
	public List<PartyBoardVO> selectPartyBoardList(PartyBoardVO partyBoard){
		return partyBoardMapper.selectPartyBoardList(partyBoard);
	}
	
	//소모임 게시판 게시글 선택해서 상세 정보불러오기
	public PartyBoardVO selectPartyBoard(int pbNum) {
		return partyBoardMapper.selectPartyBoard(pbNum);
	}
	
	//소모임 게시판 게시글 등록
	public int insertPartyBoard(PartyBoardVO partyBoard) {
		return partyBoardMapper.insertPartyBoard(partyBoard);
	}
	
	//소모임 게시판 게시글 수정
	public int updatePartyBoard(PartyBoardVO partyBoard) {
		return partyBoardMapper.updatePartyBoard(partyBoard);
	}
	
	//소모임 게시판 게시글 삭제(비활성화됨)
	public int deletePartyBoard(int pbNum) {
		return partyBoardMapper.updatePartyBoardActive(pbNum);
	}
	
}
