package com.yummyclimbing.service.party;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.exception.AuthException;
import com.yummyclimbing.mapper.party.PartyCommentMapper;
import com.yummyclimbing.mapper.party.PartyInfoMapper;
import com.yummyclimbing.mapper.party.PartyMemberMapper;
import com.yummyclimbing.util.HttpSessionUtil;
import com.yummyclimbing.vo.party.PartyMemberVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PartyMemberService {

	@Autowired
	private PartyMemberMapper partyMemberMapper;
	
	@Autowired
	private PartyCommentMapper partyCommentMapper;
	
	@Autowired
	private PartyInfoMapper partyInfoMapper;

	// 소소모임 회원 가입
	public String joinPartyMember(PartyMemberVO partyMember) {
		String message = "다시 시도해주세요";
		PartyMemberVO memberCount = partyMemberMapper.selectMemberCount(partyMember.getPiNum());
		if (memberCount.getMemNum() == memberCount.getPiMemberCnt()) {
			throw new AuthException("모집완료된 소소모임입니다.");
		}
		
		partyMember.setUiNum(HttpSessionUtil.getUserInfo().getUiNum());
		PartyMemberVO memberCheck = partyMemberMapper.selectMemberAuth(partyMember);
		if (memberCheck == null) {
			partyMember.setPmGrade(0);
			log.debug("memberCheck=>{}", memberCheck);
			if (partyMemberMapper.insertPartyMember(partyMember)) {
				return joinAndCompleteParty(memberCount, partyMember);
			}
		} else {
			if (memberCheck.getPmGrade() == 1) {
				throw new AuthException("해당 소소모임의 방장입니다.");
			}
			int pmActive = memberCheck.getPmActive();
			if (pmActive == 0) {
				if (partyMemberMapper.rejoinParty(partyMember) == 1) {
					return joinAndCompleteParty(memberCount, partyMember);
				}
			} else if (pmActive == 1) {
				throw new AuthException("이미 가입한 부원입니다.");
			} else if (pmActive == -1) {
				message = "소소모임에 가입하실 수 없습니다";
			}
		}
		return message;
	}
	
	// 가입과 함께 소소모임 모집완료 
	public String joinAndCompleteParty(PartyMemberVO memberCount, PartyMemberVO partyMember) {
		if (memberCount.getMemNum() + 1 == memberCount.getPiMemberCnt()) {
			partyInfoMapper.updatePartyComplete(partyMember.getPiNum());
		}
		return "소소모임에 가입되었습니다";
	}

	// 소소모임 회원 탈퇴(비활성화)
	public boolean quitPartyMember(PartyMemberVO partyMember) {
		partyMember.setUiNum(HttpSessionUtil.getUserInfo().getUiNum());
		if (partyMemberMapper.selectMemberAuth(partyMember).getPmGrade() == 1) {
			throw new AuthException("방장은 탈퇴할 수 없습니다.");
		}
		if (partyMemberMapper.quitPartyMember(partyMember) == 1) {
			partyCommentMapper.updateAllCommentInactive(partyMember);
			return true;
		}
		return false;
	}

	// 소소모임 권한(대장/부원) 확인
	public PartyMemberVO checkMemberAuth() {
		PartyMemberVO checkMember = new PartyMemberVO(
				Integer.parseInt(HttpSessionUtil.getRequest().getParameter("piNum")),
				HttpSessionUtil.getUserInfo().getUiNum());
		PartyMemberVO memberAuth = partyMemberMapper.selectMemberAuth(checkMember);
		if (memberAuth == null) {
			throw new AuthException("부원이 아닙니다.");
		}
		return memberAuth;
	}

}
