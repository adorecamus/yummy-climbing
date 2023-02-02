package com.yummyclimbing.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import com.yummyclimbing.service.party.PartyMemberService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Configuration
@AllArgsConstructor
@Slf4j
public class PartyAuthInterceptorForAPI implements HandlerInterceptor {

	private final PartyMemberService partyMemberService;

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.debug("~~~~~~~~~~~API 인터셉터 : 부원 아니면 에러~~~~~~~~~~~~");
		partyMemberService.checkMemberAuth();
		return true;
	}

}
