package com.yummyclimbing.vo.community;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CommunityFileInfoVO {

	private int cfNum; 			// 파일 번호 (기본키)
	private int cbNum;			// 게시판 번호 (외래키)
	private String cfName; 		// 파일명
	private String cfPath1; 	// 파일 경로1	
	private String cfPath2; 	// 파일 경로2	
	private String cfPath3; 	// 파일 경로3	
	private String cfContent;	// 파일 내용
	
	private MultipartFile file1; 
	private MultipartFile file2; 
	private MultipartFile file3; 		
	
	private List<MultipartFile> multipartFiles;
}

