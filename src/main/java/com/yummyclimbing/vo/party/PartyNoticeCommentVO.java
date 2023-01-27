package com.yummyclimbing.vo.party;

import lombok.Data;

@Data
public class PartyNoticeCommentVO {

	private int pncNum;			//소모임 공지 댓글 번호
	private String pncComment;	//소모임 공지 댓글 내용
	private String pncCredat;	//소모임 공지 댓글 등록일
	private String pncCretim;	//소모임 공지 댓글 등록시간
	private String pncLmodat;	//소모임 공지 댓글 수정일
	private String pncLmotim;	//소모임 공지 댓글 수정시간
	private int pncActive;		//소모임 공지 댓글 등록시 0-> 삭제시 1
	
	private int piNum;			//소모임 번호
	private int pnNum;			//소모임 공지 번호
	private int uiNum;			//유저 번호
	private String uiNickname;	//유저 닉네임
}
