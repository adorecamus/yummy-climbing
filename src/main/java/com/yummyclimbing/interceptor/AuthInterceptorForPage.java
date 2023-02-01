package com.yummyclimbing.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import com.yummyclimbing.exception.AuthException;
import com.yummyclimbing.util.HttpSessionUtil;

import lombok.extern.slf4j.Slf4j;

@Configuration
@Slf4j
public class AuthInterceptorForPage implements HandlerInterceptor{
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		try {
			log.debug("~~~~~~~~~~~interceptor for page~~~~~~~~~~~~");
			HttpSessionUtil.getUserInfo();
		}catch(AuthException e) {
			response.sendRedirect("/views/user/login");
			return false;
		}
		return true;
	}
}
