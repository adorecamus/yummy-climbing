package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyBoardVO;

public interface PartyBoardMapper {

	List<PartyBoardVO> selectPartyBoardList(PartyBoardVO partyBoard);
	PartyBoardVO selectPartyBoardNotice(PartyBoardVO partyBoard);
	int insertPartyBoard(PartyBoardVO partyBoard);
	int updatePartyBoard(PartyBoardVO partyBoard);
	int deletePartyBoard(int pbNum);
}
