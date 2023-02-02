package com.yummyclimbing.vo.party;

import lombok.Data;

@Data
public class PartyMemberVO {

	public PartyMemberVO () {
		
	}
	
	public PartyMemberVO (int piNum, int uiNum) {
		this.piNum = piNum;
		this.uiNum = uiNum;
	}
	
	private int pmNum;			//소모임 회원 번호(프라임키)
	private String pmCredat;	//소모임 가입날짜
	private String pmLmodat;	//소모임 탈퇴날짜
	private int pmActive;		//소모임 회원 활성화(비활성화) 가입시 1-> 탈퇴시 0
	private int pmGrade;		//소모임 권한 - 방장 1, 회원 0
	
	private int piNum;			//소모임 번호(외래키)
	private int uiNum;			//유저 번호(외래키)
	
	private String uiNickname;	//유저 닉네임
	
}
