package com.yummyclimbing.mapper.party;

import java.util.List;

import com.yummyclimbing.vo.party.PartyBoardNoticeVO;
import com.yummyclimbing.vo.party.PartyBoardVO;

public interface PartyBoardNoticeMapper {

	//소모임 공지사항
	List<PartyBoardNoticeVO> selectPartyNoticeList(PartyBoardNoticeVO partyBoardNotice);
	PartyBoardNoticeVO selectPartyNotice(int pbnNum);
	int insertPartyNotice(PartyBoardNoticeVO partyBoardNotice);
	int updatePartyNotice(PartyBoardNoticeVO partyBoardNotice);
	int updatePartyNoticeActive(int pbnNum);
}

