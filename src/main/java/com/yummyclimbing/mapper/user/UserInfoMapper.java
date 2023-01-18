package com.yummyclimbing.mapper.user;

import com.yummyclimbing.vo.user.UserInfoVO;

public interface UserInfoMapper {

	UserInfoVO loginUserInfo(UserInfoVO userInfo);
	UserInfoVO selectUserInfo(int uiNum);
	int insertUserInfo(UserInfoVO userInfo);
	UserInfoVO selectUserInfoById(String uiId);
	UserInfoVO selectUserInfoByNickname(String uiNickname);
	int updateUserInfo(UserInfoVO userInfo);
}
