package com.yummyclimbing.util;

import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

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
	
	public static UserInfoVO getSessionUserInfo() {
		HttpSession session = getSession();
		return (UserInfoVO) session.getAttribute("userInfo");
	}
	
	public static void setAttribute(String key, Object value) {
		HttpSession session = getSession();
		session.setAttribute(key, value);
	}
	
	public static void setSessionUserInfo(UserInfoVO value) {
		HttpSession session = getSession();
		session.setAttribute("userInfo", value);
	}
	
}
