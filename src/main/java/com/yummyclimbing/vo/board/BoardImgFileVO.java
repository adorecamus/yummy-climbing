package com.yummyclimbing.vo.board;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardImgFileVO {

	private int bifNum; // 게시글 이미지 번호 (기본키)
	private String bifImgPath; //게시글 이미지 경로
	private int biNum; // 게시판 번호 (외래키)
	private String bifCredat; // 게시글 등록일자
	private String bifModdat; // 게시글 수정일자 
	private MultipartFile biFile;
	private String bifContent;
	private String bifName;
}
