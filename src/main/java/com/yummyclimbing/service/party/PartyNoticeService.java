package com.yummyclimbing.service.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyNoticeMapper;
import com.yummyclimbing.mapper.party.PartyInfoMapper;
import com.yummyclimbing.vo.party.PartyNoticeVO;
import com.yummyclimbing.vo.party.PartyInfoVO;

@Service
public class PartyNoticeService {

	@Autowired
	private PartyNoticeMapper partyNoticeMapper;
	@Autowired
	private PartyInfoMapper partyInfoMapper;
	

	//소모임 공지게시판(방장만 가능)
	//소모임 공지사항 리스트
	public List<PartyNoticeVO> selectPartyNoticeList(PartyNoticeVO partyNotice){
		return partyNoticeMapper.selectPartyNoticeList(partyNotice);
	}
	
	//소모임 공지사항 선택해서 상세 정보불러오기
	public PartyNoticeVO selectPartyNotice(int pnNum) {
		return partyNoticeMapper.selectPartyNotice(pnNum);
	}
	
	//소모임 공지사항 작성
	public int insertPartyNotice(PartyNoticeVO partyNotice) {
		return partyNoticeMapper.insertPartyNotice(partyNotice);
	}
	
	//소모임 공지사항 수정
	public int updatePartyNotice(PartyNoticeVO partyNotice) {
		return partyNoticeMapper.updatePartyNotice(partyNotice);
	}
	
	//소모임 공지사항 삭제(비활성화됨)
	public int deletePartyNotice(int pnNum) {
		return partyNoticeMapper.updatePartyNoticeActive(pnNum);
	}
}
