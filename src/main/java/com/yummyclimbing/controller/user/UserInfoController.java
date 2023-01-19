package com.yummyclimbing.controller.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.user.UserInfoService;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserInfoController {

	@Autowired
	private UserInfoService userInfoService;
//	로그인
	@PostMapping("/login")
	public @ResponseBody UserInfoVO login(@RequestBody UserInfoVO userInfo, HttpSession session) {
		UserInfoVO loginUserInfo = userInfoService.selectUserInfo(userInfo);
		if(loginUserInfo !=null) {
			session.setAttribute("userInfo", loginUserInfo);
			loginUserInfo.setUiPwd(null);
		}
		log.debug("loginUserInfo=>{}", loginUserInfo);
		return loginUserInfo;
	}
	
	
//	회원가입
	@PostMapping("/sign-up")
	public @ResponseBody int addUserInfo(@RequestBody UserInfoVO userInfo) {
		return userInfoService.insertUserInfo(userInfo);
	}
//	회원가입 시 아이디 중복 체크
	@GetMapping("/sign-up/checkId/{uiId}") 
	public @ResponseBody boolean existId(@PathVariable("uiId") String uiId) {
		return userInfoService.existId(uiId);
	}
//	회원가입 시 닉네임 중복 체크		
	@GetMapping("/sign-up/checkNickname/{uiNickname}")
	public @ResponseBody boolean existNickname(@PathVariable("uiNickname") String uiNickname) {
		return userInfoService.existNickname(uiNickname);
	}
	
//	회원정보수정
	@PatchMapping("/sign-up/{uiNum}")
	public @ResponseBody boolean modifyUserInfo(@RequestBody UserInfoVO userInfo, @PathVariable("uiNum") int uiNum, HttpSession session) {
		UserInfoVO sessioUserInfo = (UserInfoVO) session.getAttribute("userInfo");
		if(sessioUserInfo==null || sessioUserInfo.getUiNum()!=uiNum) {
			throw new RuntimeException("잘못된 정보 수정 입니다.");
		}
		userInfo.setUiNum(uiNum);
		return userInfoService.updateUserInfo(userInfo, session);
	}
	
//	정보수정시 회원비번 확인
	@PostMapping("/user-infos/{uiNum}")
	public @ResponseBody boolean checkPassword(@RequestBody UserInfoVO userInfo, @PathVariable("uiNum") int uiNum, HttpSession session) {
		UserInfoVO sessionUserInfo = (UserInfoVO) session.getAttribute("userInfo");
		if(sessionUserInfo==null || sessionUserInfo.getUiNum()!=uiNum) {
			throw new RuntimeException("잘못된 접근입니다.");
		}
		userInfo.setUiNum(uiNum);
		return userInfoService.updateUserInfo(userInfo, session);
	}
	
	
//	회원탈퇴(비활성화)
	@DeleteMapping("/user-Infos/{uiNum}")
	public @ResponseBody int deleteUserInfo(@PathVariable("uiNum") int uiNum) {
		return userInfoService.deletUserInfo(uiNum);
	}
}
