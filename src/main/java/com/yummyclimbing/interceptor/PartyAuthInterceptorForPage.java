package com.yummyclimbing.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import com.yummyclimbing.service.party.PartyMemberService;
import com.yummyclimbing.util.HttpSessionUtil;
import com.yummyclimbing.vo.party.PartyMemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Configuration
@AllArgsConstructor
@Slf4j
public class PartyAuthInterceptorForPage implements HandlerInterceptor {

	private final PartyMemberService partyMemberService;

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.debug("~~~~~~~~~~~페이지 인터셉터 : 부원인지 확인할 거야~~~~~~~~~~~~");
		
		int piNum = Integer.parseInt(request.getParameter("piNum"));
		log.debug("~~~~~~~~~~~param piNum=>{}", piNum);
		
		PartyMemberVO checkMember = new PartyMemberVO();
		checkMember.setPiNum(piNum);
		checkMember.setUiNum(HttpSessionUtil.getUserInfo().getUiNum());
		PartyMemberVO memberAuth = partyMemberService.checkMemberAuth(checkMember);
		log.debug("~~~~~~~~~~~Member Auth=>{}", memberAuth);
		
		request.setAttribute("memberAuth", memberAuth);
		return true;
	}
}
