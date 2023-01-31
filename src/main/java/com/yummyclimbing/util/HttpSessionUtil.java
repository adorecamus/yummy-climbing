package com.yummyclimbing.util;

import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.yummyclimbing.exception.AuthException;
import com.yummyclimbing.vo.user.UserInfoVO;

public class HttpSessionUtil {

	public static HttpSession getSession() {
		ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		return attr.getRequest().getSession();
	}

	public static Object getAttribute(String key) {
		HttpSession session = getSession();
		return session.getAttribute(key);
	}

	public static UserInfoVO getUserInfo() throws AuthException {
		if (getAttribute("userInfo") == null) {
			throw new AuthException("로그인이 필요합니다.");
		}
		return (UserInfoVO) getAttribute("userInfo");
	}

	public static boolean isLogin() {
		try {
			getUserInfo();
		}catch(AuthException e) {
			return false;
		}
		return true;
	}

	public static void setAttribute(String key, Object value) {
		HttpSession session = getSession();
		session.setAttribute(key, value);
	}

	public static void setUserInfo(UserInfoVO userInfo) {
		setAttribute("userInfo", userInfo);
	}

}
