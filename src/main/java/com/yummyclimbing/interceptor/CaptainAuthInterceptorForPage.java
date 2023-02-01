package com.yummyclimbing.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import com.yummyclimbing.exception.AuthException;
import com.yummyclimbing.service.party.PartyInfoService;

import lombok.extern.slf4j.Slf4j;

@Configuration
@Slf4j
public class CaptainAuthInterceptorForPage implements HandlerInterceptor {

	@Autowired
	private PartyInfoService partyInfoService;

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		try {
			log.debug("~~~~~~~~~~~인터셉터 : 방장 아니면 돌아가~~~~~~~~~~~~");
			partyInfoService.checkCaptainAuth();
		} catch (AuthException e) {
//			response.sendRedirect("/views/error");	// 에러 페이지를 만드는 게 나을까요?!!
			response.sendRedirect("/views/party/view?piNum=" + request.getParameter("piNum"));
			return false;
		}
		return true;
	}
}
