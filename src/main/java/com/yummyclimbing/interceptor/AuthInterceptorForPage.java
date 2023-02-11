package com.yummyclimbing.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import com.yummyclimbing.exception.AuthException;
import com.yummyclimbing.service.party.PartyInfoService;
import com.yummyclimbing.service.party.PartyMemberService;
import com.yummyclimbing.service.user.UserInfoService;
import com.yummyclimbing.util.HttpSessionUtil;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Configuration
@AllArgsConstructor
@Slf4j
public class AuthInterceptorForPage implements HandlerInterceptor {

	private final PartyInfoService partyInfoService;

	private final PartyMemberService partyMemberService;

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
//		if (!HttpSessionUtil.isLogin()) {
//			log.debug("~~~~~~~~~~~로그안 안 되어 있다~~~~~~~~~~~~~~");
//			UserInfoVO userInfo = new UserInfoVO();
//			userInfo.setUiNum(1);
//			HttpSessionUtil.setUserInfo(userInfo);
//			log.debug("~~~~~~~~~~~세션에 test 계정 넣었다~~~~~~~~~~~~~");
//		}

		log.debug("~~~~~~~~~~~페이지 인터셉터 : 로그인 안 하면 돌아가~~~~~~~~~~~~");
		try {
			HttpSessionUtil.getUserInfo();
		} catch (AuthException e) {
			response.sendRedirect("/views/user/login");
			return false;
		}

		String uri = request.getRequestURI();
		
		log.debug("~~~~~~~~~~~부원인지 확인할 거야~~~~~~~~~~~~");
		if (uri.startsWith("/views/party/view")) {
			try {
				request.setAttribute("memberAuth", partyMemberService.checkMemberAuth());
			} catch (AuthException ae) {
				return true;
			}
		}
		
		log.debug("~~~~~~~~~~~방장 아니면 돌아가~~~~~~~~~~~~");
		if (uri.startsWith("/views/party/edit")) {
			try {
				partyInfoService.checkCaptainAuth();
			} catch (AuthException e) {
				response.sendRedirect("/views/party/view?piNum=" + request.getParameter("piNum"));
				return false;
			}
		}
		
		return true;
	}
}
