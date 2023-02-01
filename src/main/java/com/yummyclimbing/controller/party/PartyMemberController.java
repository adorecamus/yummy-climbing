package com.yummyclimbing.controller.party;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.party.PartyMemberService;
import com.yummyclimbing.vo.party.PartyMemberVO;

@Controller
public class PartyMemberController {

	@Autowired
	private PartyMemberService partyMemberService;
	
	//소모임 회원 가입
	@PostMapping("/party-member")
	@ResponseBody
	public String joinPartyMember(@RequestBody PartyMemberVO partyMember) {
		return partyMemberService.joinPartyMember(partyMember);
	}

	//소모임 회원 탈퇴-> 탈퇴한 회원이 작성한 글이 모두 삭제됨(비활성화)
	@DeleteMapping("/party-member")
	@ResponseBody
	public boolean quitPartyMember(@RequestBody PartyMemberVO partyMember, HttpSession session) {
		return partyMemberService.quitPartyMember(partyMember, session);
	}

}
