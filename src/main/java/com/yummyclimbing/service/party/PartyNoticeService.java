package com.yummyclimbing.service.party;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyMemberMapper;
import com.yummyclimbing.mapper.party.PartyNoticeMapper;
import com.yummyclimbing.util.HttpSessionUtil;
import com.yummyclimbing.vo.party.PartyMemberVO;
import com.yummyclimbing.vo.party.PartyNoticeVO;
import com.yummyclimbing.vo.user.UserInfoVO;

@Service
public class PartyNoticeService {

	@Autowired
	private PartyNoticeMapper partyNoticeMapper;
	@Autowired
	private PartyMemberMapper partyMemberMapper;
	

	//소모임 공지사항 리스트
	public List<PartyNoticeVO> selectPartyNoticeList(PartyNoticeVO partyNotice){
		return partyNoticeMapper.selectPartyNoticeList(partyNotice);
	}
	
	//소모임 공지사항 선택해서 상세 정보불러오기
	public PartyNoticeVO selectPartyNotice(int pnNum) {
		return partyNoticeMapper.selectPartyNotice(pnNum);
	}
	
	//소모임 공지사항 작성
	public String insertPartyNotice(PartyNoticeVO partyNotice) {
		UserInfoVO sessionUserInfo = HttpSessionUtil.getUserInfo();
		partyNotice.setUiNum(sessionUserInfo.getUiNum());
		if(partyNoticeMapper.selectPartyNoticeList(partyNotice).size()<=10) {
			if(partyNoticeMapper.insertPartyNotice(partyNotice)==1) {
				return "공지가 등록되었습니다.";
			}
		} 
		return "더이상 공지를 등록할 수 없습니다.(최대 10개)";
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
