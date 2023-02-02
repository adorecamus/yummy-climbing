package com.yummyclimbing.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import com.yummyclimbing.exception.AuthException;
import com.yummyclimbing.service.party.PartyInfoService;
import com.yummyclimbing.service.user.UserInfoService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Configuration
@AllArgsConstructor
@Slf4j
public class CaptainAuthInterceptorForAPI implements HandlerInterceptor {

	private final PartyInfoService partyInfoService;

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.debug("~~~~~~~~~~~API 인터셉터 : 방장 아니면 에러~~~~~~~~~~~~");
		partyInfoService.checkCaptainAuth();
		return true;
	}

}
