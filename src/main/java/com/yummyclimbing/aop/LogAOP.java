package com.yummyclimbing.aop;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lombok.extern.slf4j.Slf4j;


@Component
@Aspect
@Slf4j
public class LogAOP {
	@Around("execution( * com.yummyclimbing.controller..*Controller.*(..))")
	public Object aroundController(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
//		log.debug("start something");
		String signatureInfo = getSignatureInfo(proceedingJoinPoint);
		ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = requestAttributes.getRequest();
		String uri = request.getRequestURI();
		log.debug("~~~~~~~~~~~~~~uri=>{}", uri);
		log.debug("start==>{}", signatureInfo);
		long startTime = System.currentTimeMillis();
		Object object = proceedingJoinPoint.proceed();
		long endTime = System.currentTimeMillis();
		log.debug("end==>{}", signatureInfo);
		log.debug("execute time=>{}", (endTime-startTime)/1000.00);
//		log.debug("end something");
		return object;
	}
	
	@Before("within(@org.springframework.web.bind.annotation.*Controller *)")
	public void beforeController(JoinPoint joinPoint) {
		log.debug("before controller");
	}
	
	@After("within(@org.springframework.web.bind.annotation.RestController *)")
	public void afterController(JoinPoint joinPoint) {
		log.debug("after controller");
	}
	
	private String getSignatureInfo(JoinPoint joinPoint) {
		String signatureName = joinPoint.getSignature().getName();
		String className = joinPoint.getTarget().getClass().getSimpleName();
		StringBuilder sb = new StringBuilder();
		sb.append(className).append('.').append(signatureName).append('(');
		Object[] args = joinPoint.getArgs();
		if (args != null && args.length > 0) {
			for (int i = 0; i < args.length; i++) {
				if (args[i] instanceof String)
					sb.append('\"');
				sb.append(args[i]);
				if (args[i] instanceof String)
					sb.append('\"');
				if (i < args.length - 1) {
					sb.append(',');
				}
			}
		}
		sb.append(')');
		return sb.toString();
	}
	
}
