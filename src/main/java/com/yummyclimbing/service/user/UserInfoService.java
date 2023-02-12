package com.yummyclimbing.service.user;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.security.auth.message.AuthException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.yummyclimbing.exception.UserInputException;
import com.yummyclimbing.mapper.party.PartyInfoMapper;
import com.yummyclimbing.mapper.party.PartyMemberMapper;
import com.yummyclimbing.mapper.user.UserInfoMapper;
import com.yummyclimbing.util.HttpSessionUtil;
import com.yummyclimbing.util.SHA256;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserInfoService {

	private static final String BASE_PATH;
	static {
		String osName = System.getProperty("os.name");
		if (osName.toUpperCase().contains("WINDOW")) {
			BASE_PATH = "C:";
		} else {
			BASE_PATH = "";
		}
	}

	@Autowired
	private UserInfoMapper userInfoMapper;

	@Autowired
	private PartyInfoMapper partyInfoMapper;

	@Autowired
	private PartyMemberMapper partyMemberMapper;

//	로그인 
	public UserInfoVO selectUserInfo(UserInfoVO userInfo) {
		userInfo.setUiPwd(SHA256.encode(userInfo.getUiPwd()));
		return userInfoMapper.loginUserInfo(userInfo);
	}

	// 회원가입
	public int insertUserInfo(UserInfoVO userInfo) {
		String userPwd = userInfo.getUiPwd();
		String patternPwd = SHA256.encode(userPwd);
		userInfo.setUiPwd(patternPwd);
		return userInfoMapper.insertUserInfo(userInfo);
	}

	// ID 찾기
	public UserInfoVO findId(UserInfoVO userInfo) {
		return userInfoMapper.findUserId(userInfo);
	}

	// PWD 초기화
	public int findPwd(UserInfoVO userInfo) {
		log.debug(userInfo.getUiPwd());
		userInfo.setUiPwd(SHA256.encode("123456789a"));
		log.debug(userInfo.getUiPwd());
		return userInfoMapper.findUserPwd(userInfo);
	}

//	아이디 중복검사
	public boolean existId(String uiId) {
		if (userInfoMapper.selectUserInfoById(uiId) != null) {
			return true;
		} else {
			return false;
		}
	}

//	닉네임 중복검사
	public boolean existNickname(String uiNickname) {
		if (userInfoMapper.selectUserInfoByNickname(uiNickname) == null) {
			return false;
		} else {
			return true;
		}
	}

	// 정보수정
	public boolean updateUserInfo(UserInfoVO userInfo, int uiNum) throws AuthException {
		UserInfoVO sessionUserInfo = HttpSessionUtil.getUserInfo();
		if (sessionUserInfo.getUiNum() != uiNum) {
			// 세션에서 가져온 uiNum이 매개값으로 받아온 Num이랑 다를시
			throw new RuntimeException("잘못된 정보 수정입니다.");
		}
		userInfo.setUiNum(uiNum);
		// 같을 시 매개변수에 옳은 uiNum을 넣어주고
		// 보내주는 매개변수 유저인포 객체로 업데이트를 하고 다시 조회하고 비번을 초기화 하고 기존의 세션값에 변한값을 적용
		if (userInfoMapper.updateUserInfo(userInfo) == 1) {
			UserInfoVO tmpUserInfo = userInfoMapper.selectUserInfo(userInfo.getUiNum());
			tmpUserInfo.setUiPwd(null);
			HttpSessionUtil.setUserInfo(tmpUserInfo);
			return true;
		}
		return false;
	}

	// 프로필 사진 업로드

	public boolean profileUpload(UserInfoVO userInfo, int uiNum) throws IllegalStateException, IOException {
		userInfo.setUiNum(uiNum);
		if (userInfo.getUiNum() != HttpSessionUtil.getUserInfo().getUiNum()) {
			throw new RuntimeException("잘못된 접근 방식입니다.");
		}

		MultipartFile file = userInfo.getMultipartFile();
		if (file == null) {
			throw new UserInputException("업로드한 파일이 없습니다.");
		}

		String uifName = file.getOriginalFilename();
		int lastIndex = uifName.lastIndexOf(".");
		String extName = uifName.substring(lastIndex);
		String uiImgPath = UUID.randomUUID().toString() + extName;
		String fullPath = BASE_PATH + "/java-works/userImg/" + uiImgPath;
		userInfo.setUiImgPath(uiImgPath);
		if (userInfoMapper.profileUpload(userInfo) == 1) {
			File tmpFile = new File(fullPath);
			file.transferTo(tmpFile);
			UserInfoVO tmpUserInfo = userInfoMapper.selectUserInfo(uiNum);
			tmpUserInfo.setUiPwd(null);
			HttpSessionUtil.setUserInfo(tmpUserInfo);
			return true;
		}
		return false;
	}

	// 비밀번호 확인
	public boolean checkPassword(UserInfoVO userInfo, int uiNum) {
		UserInfoVO tmpUserInfo = userInfoMapper.selectUserInfo(uiNum);
		if (tmpUserInfo != null) {
			String uiPwd = userInfo.getUiPwd();
			String encodePwd = SHA256.encode(uiPwd);
			if (encodePwd.equals(tmpUserInfo.getUiPwd())) {
				return true;
			}
		}
		return false;
	}

	// 회원탈퇴(비활성화)
	public boolean deleteUserInfo(int uiNum) {

		if (userInfoMapper.deleteUserInfo(uiNum) == 1) {
			partyMemberMapper.deleteLinkedMember(uiNum);
			partyInfoMapper.deleteLinkedParty(uiNum);
			HttpSessionUtil.getSession().invalidate();
			return true;
		}
		return false;

	}

}
