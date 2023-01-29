package com.yummyclimbing.vo.community;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CommunityBoardImgFileVO {

		private int cifNum; 		// 게시글 이미지 번호 (기본키)
		private String cifImgPath; 	//게시글 이미지 경로
		private int cbNum; 			// 게시판 번호 (외래키)
		private String cifCredat; 	// 게시글 등록일자
		private String cifModdat; 	// 게시글 수정일자 
		private MultipartFile ciFile;	
		private String cifContent;	// 이미지파일 내용
		private String cifName;		// 이미지파일 이름
	}

