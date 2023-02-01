package com.yummyclimbing.vo.community;

import lombok.Data;

@Data
public class CommunityFileInfoVO {

	private int cfNum; 			// 파일 번호 (기본키)
	private int cbNum;			// 게시판 번호 (외래키)
	private String cfOrigName; 	// 원본 파일명
	private String cfLogiName;  // 저장 파일명
	private String cfLogiPath; 	// 파일 경로	
	private String cfExt;		// 파일 확장자
	private long cfSize;			// 파일 크기
	private String cfCredat;	// 파일 등록일자
}

