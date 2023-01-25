package com.yummyclimbing.controller.user;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.user.UserChallengeService;
import com.yummyclimbing.vo.user.UserChallengeVO;

@Controller
public class UserChallengeController {

	private UserChallengeService userChallengeService;
	
	@GetMapping("/challenge-list/{uiNum}")
	public @ResponseBody List<UserChallengeVO> getChallengeList(@ModelAttribute UserChallengeVO userChallenge) {
		return userChallengeService.selectUserChallengeList(userChallenge);
	}
}
