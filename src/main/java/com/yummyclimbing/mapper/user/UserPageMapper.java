package com.yummyclimbing.mapper.user;

import java.util.List;

import com.yummyclimbing.vo.user.UserPageVO;

public interface UserPageMapper {

	List<UserPageVO> getMyParty(int uiNum);
}
