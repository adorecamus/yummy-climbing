package com.yummyclimbing.aop;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.yummyclimbing.vo.party.PartyMemberVO;

import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@Slf4j
public class ControllerAOP {

	@Around("@annotation(com.yummyclimbing.anno.CheckAuth)")
	public Object aroundController(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
		ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = requestAttributes.getRequest();
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfo")==null) {
			return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
		}
		return proceedingJoinPoint.proceed();
	}
	
	@Around("execution(* com.yummyclimbing.controller.ViewsController.goPage(..))")
	public Object viewAuthCheck(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
		ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = requestAttributes.getRequest();
		HttpSession session = request.getSession();
		String uri = request.getRequestURI();
//		if(uri.startsWith("/views/party/create") && session.getAttribute("userInfo")==null) {
//			request.setAttribute("msg", "로그인이 필요합니다.");
//			return "views/user/login";
//		}
//		
//		if(uri.startsWith("/views/party/notice")) {
//			List<PartyMemberVO> partyMemberInfoList = (List<PartyMemberVO>) session.getAttribute("partyMemberInfo");
//			for (PartyMemberVO partyMemberInfo : partyMemberInfoList) {
//				partyMemberInfo.getPiNum();
//			}
//			return null;
//		}
		return proceedingJoinPoint.proceed();
	}
	
	private boolean checkPartyMember(HttpSession session) {
		List<PartyMemberVO> partyMemberInfoList = (List<PartyMemberVO>) session.getAttribute("partyMemberInfo");
		for (PartyMemberVO partyMemberInfo : partyMemberInfoList) {
			partyMemberInfo.getPiNum();
		}
		return false;
	}
	
}
