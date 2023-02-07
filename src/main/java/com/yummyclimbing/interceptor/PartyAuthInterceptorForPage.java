package com.yummyclimbing.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import com.yummyclimbing.exception.AuthException;
import com.yummyclimbing.service.party.PartyMemberService;

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
		try {
			request.setAttribute("memberAuth", partyMemberService.checkMemberAuth());
		} catch (AuthException ae) {
			return true;
		}
		return true;
	}
}
