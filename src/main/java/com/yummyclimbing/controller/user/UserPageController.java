package com.yummyclimbing.controller.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.user.UserPageService;
import com.yummyclimbing.vo.user.UserPageVO;

@Controller
public class UserPageController {

	@Autowired
	private UserPageService userPageService;
	
	@GetMapping("/user-party/{uiNum}")
	@ResponseBody
	public List<UserPageVO> getUserParty(@PathVariable("uiNum") int uiNum) {
		return userPageService.getMyParty(uiNum);
	}

}