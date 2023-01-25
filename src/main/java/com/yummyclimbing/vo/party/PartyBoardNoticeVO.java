package com.yummyclimbing.vo.party;

import lombok.Data;

@Data
public class PartyBoardNoticeVO {

	private int pbnNum;				//소모임 공지사항 번호(프라임키)
	private String pbnContent;	//소모임 공지사항 내용
	private String pbnCredat;		//소모임 공지사항 등록일
	private String pbnLmodat;	//소모임 공지사항 수정일
	private String pbnCretim;		//소모임 공지사항 등록시간
	private String pbnLmotim;	//소모임 공지사항 수정시간
	private int pbnActive;			//소모임 공지사항 등록시 1->삭제시 0
	
	private int piNum;				//소모임 번호(외래키)
	private int uiNum;				//유저 번호(외래키)
	private String uiNickname;		//유저 닉네임	
}
