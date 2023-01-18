package com.yummyclimbing.service.user;

import java.io.Console;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.user.UserInfoMapper;
import com.yummyclimbing.util.SHA256;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserInfoService {

	@Autowired
	private UserInfoMapper userInfoMapper;
	
//	로그인 
	public UserInfoVO selectUserInfo(UserInfoVO userInfo) {
		userInfo.setUiPwd(SHA256.encode(userInfo.getUiPwd()));
		return userInfoMapper.loginUserInfo(userInfo);
	}
	
	//회원가입
	public int insertUserInfo(UserInfoVO userInfo) {
		String userPwd = userInfo.getUiPwd();
		//받은 유저인포값에서 패스워드를 꺼내고
		String patternPwd = SHA256.encode(userPwd);
		//패스워드를 암호화 한 후
		userInfo.setUiPwd(patternPwd);
		//유저인포에 적용한 후 리턴
		return userInfoMapper.insertUserInfo(userInfo);
	}
	
//	아이디 중복검사
	public boolean existId(String uiId) {
		if(userInfoMapper.selectUserInfoById(uiId)!=null) {
			return true;
		}else {
		return false;
		}
	}
	
//	닉네임 중복검사
	public boolean existNickname(String uiNickname) {
		if(userInfoMapper.selectUserInfoByNickname(uiNickname)==null) {
			return false;
		}else {
			return true;
		}
	}
	
	//정보수정
	public boolean updateUserInfo(UserInfoVO userInfo, HttpSession session) {
		if(userInfoMapper.updateUserInfo(userInfo)==1) {
			UserInfoVO tmpUserInfo = userInfoMapper.selectUserInfo(userInfo.getUiNum());
			session.setAttribute("userInfo", tmpUserInfo);
			return true;
		}
		return false;
	}
	
	
}
