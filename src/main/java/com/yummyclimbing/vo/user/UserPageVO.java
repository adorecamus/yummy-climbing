package com.yummyclimbing.vo.user;

import lombok.Data;

@Data
public class UserPageVO {

	private int piNum;			//소모임 번호
	private String piName;		//소모임 이름
	private int uiNum;			//유저 번호
	private int pmGrade;		//유저 회원등급(대장:1, 일반부원:0)
}
