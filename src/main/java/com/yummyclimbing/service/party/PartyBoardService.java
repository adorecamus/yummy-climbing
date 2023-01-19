package com.yummyclimbing.service.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyBoardMapper;
import com.yummyclimbing.vo.party.PartyBoardVO;

@Service
public class PartyBoardService {

	@Autowired
	private PartyBoardMapper partyBoardMapper;
	
	public List<PartyBoardVO> selectPartyBoardList(PartyBoardVO partyBoard){
		return partyBoardMapper.selectPartyBoardList(partyBoard);
	}
	
	public PartyBoardVO selectPartyBoardNotice(PartyBoardVO partyBoard) {
		return partyBoardMapper.selectPartyBoard(partyBoard);
	}
	
	public int insertPartyBoard(PartyBoardVO partyBoard) {
		return partyBoardMapper.insertPartyBoard(partyBoard);
	}
	
	public int updatePartyBoard(PartyBoardVO partyBoard) {
		return partyBoardMapper.updatePartyBoard(partyBoard);
	}
	
	public int deletePartyBoard(int pbNum) {
		return partyBoardMapper.updatePartyBoardActive(pbNum);
	}
}
