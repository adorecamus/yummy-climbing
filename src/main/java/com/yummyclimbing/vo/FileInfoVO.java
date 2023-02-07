package com.yummyclimbing.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class FileInfoVO {

	private int fiNum;
	private String fiName;
	private String fiPath;
	private String fiContent;
	
	private MultipartFile file;
	private MultipartFile file1;
	
	private List<MultipartFile> files;
	
}
