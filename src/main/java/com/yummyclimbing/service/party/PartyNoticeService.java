package com.yummyclimbing.service.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyNoticeMapper;
import com.yummyclimbing.mapper.party.PartyInfoMapper;
import com.yummyclimbing.vo.party.PartyBoardNoticeVO;
import com.yummyclimbing.vo.party.PartyBoardVO;
import com.yummyclimbing.vo.party.PartyInfoVO;

@Service
public class PartyNoticeService {

	@Autowired
	private PartyNoticeMapper partyBoardNoticeMapper;
	@Autowired
	private PartyInfoMapper partyInfoMapper;
	

	//소모임 공지게시판(방장만 가능)
	//소모임 공지사항 리스트
	public List<PartyBoardNoticeVO> selectPartyNoticeList(PartyBoardNoticeVO partyBoardNotice){
		return partyBoardNoticeMapper.selectPartyNoticeList(partyBoardNotice);
	}
	
	//소모임 공지사항 선택해서 상세 정보불러오기
	public PartyBoardNoticeVO selectPartyNotice(int pbnNum) {
		return partyBoardNoticeMapper.selectPartyNotice(pbnNum);
	}
	
	//소모임 공지사항 작성
	public int insertPartyNotice(PartyBoardNoticeVO partyBoardNotice) {
		PartyInfoVO partyInfo = new PartyInfoVO();
		if(partyInfoMapper.selectCaptainNum(partyInfo)==null) {
			return 0;
		}
		return partyBoardNoticeMapper.insertPartyNotice(partyBoardNotice);
	}
	
	//소모임 공지사항 수정
	public int updatePartyNotice(PartyBoardNoticeVO partyBoardNotice) {
		PartyInfoVO partyInfo = new PartyInfoVO();
		if(partyInfoMapper.selectCaptainNum(partyInfo)==null) {
			return 0;
		}
		return partyBoardNoticeMapper.updatePartyNotice(partyBoardNotice);
	}
	
	//소모임 공지사항 삭제(비활성화됨)
	public int deletePartyNotice(int pbnNum) {
		PartyInfoVO partyInfo = new PartyInfoVO();
		if(partyInfoMapper.selectCaptainNum(partyInfo)==null) {
			return 0;
		}
		return partyBoardNoticeMapper.updatePartyNoticeActive(pbnNum);
	}
}
