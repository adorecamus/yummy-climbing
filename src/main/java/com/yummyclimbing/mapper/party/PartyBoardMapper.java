package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyBoardVO;

public interface PartyBoardMapper {

	List<PartyBoardVO> selectPartyBoardList(PartyBoardVO partyBoard);
	PartyBoardVO selectPartyBoard(int pbNum);
	int insertPartyBoard(PartyBoardVO partyBoard);
	int updatePartyBoard(PartyBoardVO partyBoard);
	int updatePartyBoardActive(int pbNum);
	int updateQuitPartyBoardInactive(int uiNum);
}
