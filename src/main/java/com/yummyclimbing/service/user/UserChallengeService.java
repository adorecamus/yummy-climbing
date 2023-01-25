package com.yummyclimbing.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.user.UserChallengeMapper;
import com.yummyclimbing.vo.user.UserChallengeVO;

@Service

public class UserChallengeService {
	@Autowired
	private UserChallengeMapper userChallengeMapper;

	public List<UserChallengeVO> selectUserChallengeList(UserChallengeVO userChallenge) {
		return userChallengeMapper.selectUserChallengeList(userChallenge);
	}
	
}
