package com.yummyclimbing.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.user.UserPageMapper;
import com.yummyclimbing.vo.user.UserPageVO;

@Service
public class UserPageService {

	@Autowired
	private UserPageMapper userPageMapper;
	
	public List<UserPageVO> getMyParty(int uiNum) {
		return userPageMapper.getMyParty(uiNum);
	}
}
