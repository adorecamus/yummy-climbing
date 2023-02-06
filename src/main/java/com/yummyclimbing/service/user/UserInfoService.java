package com.yummyclimbing.service.user;

import javax.security.auth.message.AuthException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.user.UserInfoMapper;
import com.yummyclimbing.util.HttpSessionUtil;
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
		String patternPwd = SHA256.encode(userPwd);
		userInfo.setUiPwd(patternPwd);
		return userInfoMapper.insertUserInfo(userInfo);
	}
	
	//ID 찾기
	public UserInfoVO findId(UserInfoVO userInfo) {
		return userInfoMapper.findUserId(userInfo);
	}
	
	//PWD 찾기
	public int findPwd(UserInfoVO userInfo) {
		log.debug(userInfo.getUiPwd());
		userInfo.setUiPwd(SHA256.encode("123456789a"));
		log.debug(userInfo.getUiPwd());
		return userInfoMapper.findUserPwd(userInfo);
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
	public boolean updateUserInfo(UserInfoVO userInfo, int uiNum) throws AuthException {
		UserInfoVO sessionUserInfo = HttpSessionUtil.getUserInfo();
		if (sessionUserInfo.getUiNum() != uiNum) {
			throw new RuntimeException("잘못된 정보 수정입니다.");
		}
		userInfo.setUiNum(uiNum);
		if(userInfoMapper.updateUserInfo(userInfo)==1) {
			UserInfoVO tmpUserInfo = userInfoMapper.selectUserInfo(userInfo.getUiNum());
			tmpUserInfo.setUiPwd(null);
			HttpSessionUtil.setUserInfo(tmpUserInfo);
			return true;
		}
		return false;
	}
	

	
	
	//비밀번호 확인
	public boolean checkPassword(UserInfoVO userInfo, int uiNum) {
		UserInfoVO tmpUserInfo = userInfoMapper.selectUserInfo(uiNum);
		if(tmpUserInfo != null) {
			String uiPwd = userInfo.getUiPwd();
			String encodePwd = SHA256.encode(uiPwd);
			if(encodePwd.equals(tmpUserInfo.getUiPwd())) {
				return true;
			}
		}
		return false;
	}
	
	//회원탈퇴(비활성화)
	public boolean deleteUserInfo(UserInfoVO userInfo, int uiNum) {
			
		/*
		 * String uiNick = userInfo.getUiNickname();
		 * userInfo.setUiNickname(SHA256.encode(uiNick));
		 */
		if(userInfoMapper.deleteUserInfo(uiNum)==1) { 
				//세션을 매개변수 필요없이 불러오기
				HttpSessionUtil.getSession().invalidate();
				return true;
			}
		return false;
	}
	
	
}

