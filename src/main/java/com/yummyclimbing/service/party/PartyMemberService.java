package com.yummyclimbing.service.party;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyMemberMapper;
import com.yummyclimbing.vo.party.PartyInfoVO;
import com.yummyclimbing.vo.party.PartyMemberVO;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PartyMemberService {

	@Autowired
	private PartyMemberMapper partyMemberMapper;
	
	//소모임 회원 가입
	public boolean joinPartyMember(PartyMemberVO partyMember, HttpSession session) {
		UserInfoVO sessionUserInfo = (UserInfoVO) session.getAttribute("userInfo");
		partyMember.setUiNum(sessionUserInfo.getUiNum());
		if(partyMemberMapper.checkJoinedParty(sessionUserInfo.getUiNum())==null) {
			partyMember.setPmGrade(0);
			log.debug("partymember=>{}", partyMember);
			if(partyMemberMapper.insertPartyMember(partyMember)== true) {
				List<PartyMemberVO> partyMemberInfo = (List<PartyMemberVO>) session.getAttribute("partyMemberInfo");
				partyMemberInfo.add(partyMember);
				session.setAttribute("partyMemberInfo", partyMemberInfo);
				log.debug("session member info=>{}", partyMemberInfo);
				return true;
			}
		}
		return false;
	}
	
	//소모임 회원 탈퇴(비활성화)
	public boolean quitPartyMember(PartyMemberVO partyMember, HttpSession session) {
		UserInfoVO sessionUserInfo = (UserInfoVO) session.getAttribute("userInfo");
		partyMember.setUiNum(sessionUserInfo.getUiNum());
		if(partyMemberMapper.quitPartyMember(partyMember)==1) {
			return true;
		}
		return false;
	}
	
	// 로그인시 세션에 파티 멤버 정보 저장
	public List<PartyMemberVO> getPartyMemberInfo(int uiNum) {
		return partyMemberMapper.selectPiNumAndGradeByUiNum(uiNum);
	}
	
	
}
