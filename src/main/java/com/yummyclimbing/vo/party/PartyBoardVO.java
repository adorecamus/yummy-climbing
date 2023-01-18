package com.yummyclimbing.vo.party;

import lombok.Data;

@Data
public class PartyBoardVO {

	private int pbNum;				//소모임 게시글 번호(프라임키)
	private String pbComment;	//소모임 댓글
	private String pbCredat;		//소모임 게시글 생성일
	private String pbModdat;		//소모임 게시글 수정일
	private int piNum;				//소모임 번호(외래키)
	private int uiNum;				//유저 번호(외래키)
	private String uiId;				//유저 아이디(외래키)	
}
