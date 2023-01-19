package com.yummyclimbing.vo.party;

import lombok.Data;

@Data
public class PartyBoardCommentVO {

	private int pbcNum;			//소모임 게시물 댓글 번호(기본키)
	private String pbcComment;	//소모임 게시물 댓글 내용
	private String pbcCredat;	//소모임 게시물 댓글 작성일
	private String pbcLmodat;	//소모임 게시물 댓글 수정일
	private int pbcActive;		//소모임 게시물 댓글 등록시 1->삭제시 0
	private String pbcCretim;	//소모임 게시물 댓글 작성시간
	private String pbcLmotim;	//소모임 게시물 댓글 수정시간
	
	private int pbNum;			//소모임 게시물 번호
	private int uiNum;			//유저 번호
	private String uiNickname;	//유저 닉네임
}
