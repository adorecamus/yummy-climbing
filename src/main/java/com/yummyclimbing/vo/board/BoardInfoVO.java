package com.yummyclimbing.vo.board;

import lombok.Data;

@Data
public class BoardInfoVO {

	private int biNum; // 게시판 번호 (기본키)
	private String biCategory; //게시판 카테고리
	private String biTitle; // 제목
	private String biContent; // 내용
	private String biCredat; // 등록일자
	private String biCretim; // 등록시간
	private String biLmodat; // 수정일자
	private String biLmotim; // 수정시간
	private String biActive; // 활성화 or 비활성화
	private int biCnt; // 조회수
	private int uiNum; // 유저 번호 (외래키)
	private String uiId; // 작성자
}
