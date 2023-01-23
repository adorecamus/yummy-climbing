package com.yummyclimbing.vo.community;

import lombok.Data;

@Data
public class CommunityBoardVO {

	private int cbNum;   		// 게시판 번호 (기본키)
	private String cbCategory;  //게시판 카테고리
	private String cbTitle;		// 제목
	private String cbContent;	// 내용
	private String cbCredat;	// 등록일자
	private String cbCreTim;	// 등록시간
	private String cbLmodat;	// 수정일자
	private String cbLmotim;	// 수정시간
	private int cbActive;		// 활성화 or 비활성화
	private int cbCommentCnt;	// 댓글 수
	private int uiNum;			// 유저 번호 (외래키)
	private String uiId;		// 작성자
}