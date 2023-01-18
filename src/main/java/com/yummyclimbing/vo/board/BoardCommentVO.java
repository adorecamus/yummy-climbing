package com.yummyclimbing.vo.board;

import lombok.Data;

@Data
public class BoardCommentVO {
	
	private int bcNum; // 댓글 번호 (기본키)
	private int uiNum; // 유저 번호 (외래키)
	private String uiId; // 작성자
	private int biNum; // 게시판 번호 (외래키)
	private String bcContent; // 게시판 댓글 내용
	private int bcActive; // 활성화 or 비활성화
	private String bcCredat; // 댓글 등록일자
	private String bcCretim; // 댓글 등록시간
	private String bcModdat; // 댓글 수정일자
	private String bcModtim; // 댓글 수정시간
	private int bcCnt; // 댓글 수 
}