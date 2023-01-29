package com.yummyclimbing.controller.user;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.user.UserChallengeService;
import com.yummyclimbing.vo.user.UserChallengeVO;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserChallengeController {

	@Autowired
	private UserChallengeService userChallengeService;
	
	//	나의 챌린지 리스트 가져오기
	@GetMapping("/challenge-list/{uiNum}")
	public @ResponseBody List<UserChallengeVO> getChallengeList(@ModelAttribute UserChallengeVO userChallenge) {
		return userChallengeService.selectUserChallengeList(userChallenge);
	}
	
	//	선택한 챌린지 리스트 뷰로 보기
	@GetMapping("/challengeList/view")
	public @ResponseBody UserChallengeVO viewChallenge(@PathVariable int ucNum) {
		return userChallengeService.viewUserChallenge(ucNum);
	}
	
	//	챌린지 추가하기
	
	@PostMapping("/challenge-add")
	public @ResponseBody int insertChallenge(@RequestBody UserChallengeVO userChallenge, HttpSession session) {
		log.debug("userChallenge=>{}",userChallenge);
		UserInfoVO userInfo = (UserInfoVO) session.getAttribute("userInfo");
		if(userInfo == null) {
			throw new RuntimeException("로그인 상태가 아닙니다.");
		}
		userChallenge.setUiNum(userInfo.getUiNum());
		return userChallengeService.insertUserChallenge(userChallenge);
	}
	 
	
	//챌린지 수정하기
	/*
	 * @PatchMapping("/user-challenge/${cuNum}") public @ResponseBody int
	 * updateChallenge(@RequestBody UserChallengeVO userChallenge @PathVariable int
	 * cuNum) { return userChallengeService.updateUserChallenge(userChallenge); }
	 */
	
	//챌린지 완수/삭제하기
	/*
	 * @DeleteMapping("/user-challenge/${cuNum}") public @ResponseBody int
	 * completeChallenge(@PathVariable int ucNum) { return
	 * userChallengeService.deleteUserChallenge(ucNum); }
	 */
}
