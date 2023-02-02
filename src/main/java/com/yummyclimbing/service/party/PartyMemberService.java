package com.yummyclimbing.service.party;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyMemberMapper;
import com.yummyclimbing.util.HttpSessionUtil;
import com.yummyclimbing.vo.party.PartyInfoVO;
import com.yummyclimbing.vo.party.PartyMemberVO;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PartyMemberService {

	@Autowired
	private PartyMemberMapper partyMemberMapper;

	// 소모임 회원 가입
	public String joinPartyMember(PartyMemberVO partyMember) {
		UserInfoVO sessionUserInfo = HttpSessionUtil.getUserInfo();
		partyMember.setUiNum(sessionUserInfo.getUiNum());
		PartyMemberVO memberCheck = partyMemberMapper.checkJoinedParty(partyMember);
		if (memberCheck == null || memberCheck.getPmActive() == 0) {
			partyMember.setPmGrade(0);
			log.debug("memberCheck=>{}", memberCheck);
			if (partyMemberMapper.insertPartyMember(partyMember) == true) {
				return "소소모임에 가입되었습니다";
			}
		} else if (partyMemberMapper.checkJoinedParty(partyMember).getPmActive() == 1) {
			return "이미 가입한 회원입니다.";
		} else if (partyMemberMapper.checkJoinedParty(partyMember).getPmActive() == -1) {
			return "소소모임에 가입하실 수 없습니다";
		}
		return "다시 시도해주세요";
	}

	// 소모임 회원 탈퇴(비활성화)
	public boolean quitPartyMember(PartyMemberVO partyMember, HttpSession session) {
		UserInfoVO sessionUserInfo = (UserInfoVO) session.getAttribute("userInfo");
		partyMember.setUiNum(sessionUserInfo.getUiNum());
		if (partyMemberMapper.quitPartyMember(partyMember) == 1) {
			return true;
		}
		return false;
	}

	// 로그인시 세션에 파티 멤버 정보 저장
	public List<PartyMemberVO> getPartyMemberInfo(int uiNum) {
		return partyMemberMapper.selectPiNumAndGradeByUiNum(uiNum);
	}

	// 소소모임 권한 확인
	public PartyMemberVO checkMemberAuth(PartyMemberVO partyMember) {
		return partyMemberMapper.selectMemberAuth(partyMember);
	}

}
