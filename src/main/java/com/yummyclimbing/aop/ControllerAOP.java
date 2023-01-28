package com.yummyclimbing.aop;

import java.nio.charset.Charset;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.yummyclimbing.vo.ResponseVO;
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
			
			// ResponseEntity 이용하는 경우 (컨트롤러의 리턴 타입은 ResponseEntity<ResponseVO>)
			HttpHeaders header = new HttpHeaders();
			header.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
			ResponseVO response = new ResponseVO();
			response.setMsg("로그인이 필요합니다.");
			response.setUrl("/views/user/login");
			return new ResponseEntity<>(response, header, HttpStatus.UNAUTHORIZED);
			
			// 아니면 컨트롤러의 기존 리턴 타입으로 리턴!
			// 예를 들어
//			return false;
//			return 1;
		}
		return proceedingJoinPoint.proceed();
	}

	@Around("execution(* com.yummyclimbing.controller.ViewsController.goPage(..))")
	public Object viewAuthCheck(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
		log.debug("~~~~~~~~~~~~~~~~viewAuthCheck");
		ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = requestAttributes.getRequest();
		HttpSession session = request.getSession();
		String uri = request.getRequestURI();
		
		// 로그인해야 접근 가능한 주소
		if (uri.startsWith("/views/party/create")) {
			if (session.getAttribute("userInfo") == null) {
				request.setAttribute("msg", "로그인이 필요합니다.");
				return "views/user/login";
			}
		}
		
		// 소모임 멤버만 접근 가능한 주소
		if (uri.startsWith("/views/party/notice")) {
			if (session.getAttribute("userInfo") == null) {
				request.setAttribute("msg", "로그인이 필요합니다.");
				return "views/user/login";
			}
			int piNum = Integer.parseInt(request.getParameter("piNum"));
			log.debug("~~~~~~~~~~~param piNum=>{}", piNum);
			List<PartyMemberVO> partyMemberInfoList = (List<PartyMemberVO>) session.getAttribute("partyMemberInfo");
			for (PartyMemberVO partyMemberInfo : partyMemberInfoList) {
				log.debug("~~~~~~~~~userPiNum=>{}", partyMemberInfo.getPiNum());
				log.debug("~~~~~~~~~userPmGrade=>{}", partyMemberInfo.getPmGrade());
				if (partyMemberInfo.getPiNum() == piNum) {
					if (partyMemberInfo.getPmGrade() == 1) {
						log.debug("~~~~~~~~~captain");
						request.setAttribute("captain", 1);
					}
					return proceedingJoinPoint.proceed();
				}
			}
			request.setAttribute("msg", "해당 소소모임 회원이 아닙니다.");
			return "views/party/join";
		}
		return proceedingJoinPoint.proceed();
	}
	
	private void checkLogin(ProceedingJoinPoint proceedingJoinPoint, List<String> uriList) {
//		HttpSession session = request.getSession();
//		if (session.getAttribute("userInfo") == null) {
//			request.setAttribute("msg", "로그인이 필요합니다.");
//			return "views/user/login";
//		}
	}

}
