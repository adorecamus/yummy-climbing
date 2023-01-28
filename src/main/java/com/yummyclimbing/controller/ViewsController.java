package com.yummyclimbing.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.yummyclimbing.anno.CheckAuth;
import com.yummyclimbing.anno.MemberOnly;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ViewsController {

	@GetMapping("/")
	public String goHome() {
		return "views/index";
	}
	
	@GetMapping("/views/**")
	public String goPage(HttpServletRequest request) {
		String uri = request.getRequestURI();
		return uri.substring(1);
	}

	
	
	// 주소 앞에 views 안 붙게 하려면 아래와 같이 url 매핑을 해줌..
	
//	@GetMapping("/{uri1}")
//	public String goPage(@PathVariable("uri1") String uri1) {
//		log.debug("~~~~~~~~~~~~~~~uri1");
//		return "views/" + uri1;
//	}
//	
//	@GetMapping("/{uri1}/{uri2}")
//	public String goPage(@PathVariable("uri1") String uri1, @PathVariable("uri2") String uri2) {
//		log.debug("~~~~~~~~~~~~~~~uri1 / uri2");
//		return "views/" + uri1 + "/" + uri2;
//	}
	
	
	// application.yml 에서 view.prefix를 /WEB-INF/views/ 로 바꾼다면 아래와 같음..
	
//	@GetMapping("/{uri1}")
//	public String goPage(@PathVariable("uri1") String uri1) {
//		log.debug("~~~~~~~~~~~~~~~uri1");
//		return uri1;
//	}
//	
//	@GetMapping("/{uri1}/{uri2}")
//	public String goPage(@PathVariable("uri1") String uri1, @PathVariable("uri2") String uri2) {
//		log.debug("~~~~~~~~~~~~~~~uri1 / uri2");
//		return uri1 + "/" + uri2;
//	}
	
}
