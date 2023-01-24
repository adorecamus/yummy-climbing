package com.yummyclimbing.vo.party;

import lombok.Data;

@Data
public class PartyBoardVO {

	private int pbNum;				//소모임 게시물 번호(프라임키)
	private String pbContent;		//소모임 게시물 내용
	private String pbCredat;		//소모임 게시물 등록일
	private String pbLmodat;		//소모임 게시물 수정일
	private String pbCretim;		//소모임 게시물 등록시간
	private String pbLmotim;		//소모임 게시물 수정시간
	private int pbActive;			//소모임 게시물 등록시 1-> 삭제시 0
	
	
	private int piNum;				//소모임 번호(외래키)
	private int uiNum;				//유저 번호(외래키)
	private String uiNickname;		//유저 닉네임	
}
