package com.yummyclimbing.vo.party;

import lombok.Data;

@Data
public class PartyMemberVO {

	private int pmNum;		//소모임 회원 번호(프라임키)
	private int pmCaptain;	//소모임 방장
	private int piNum;		//소모임 번호(외래키)
	private int uiNum;		//유저 번호(외래키)
	private int pmActive;	//소모임 회원 활성화(비활성화) 가입시 1-> 탈퇴시 0
}
