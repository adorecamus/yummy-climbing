package com.yummyclimbing.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.yummyclimbing.util.FileUtil;
import com.yummyclimbing.service.FileInfoService;
import com.yummyclimbing.vo.FileInfoVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class FileInfoController {
	
	@Autowired
	private FileInfoService fileInfoService;
	
	/*
	@PostMapping("/file-upload")
	public String fileUpload(@RequestPart("file") MultipartFile multipartFile) throws IllegalStateException, IOException {
		String path = "C:/java-works/upload/" + multipartFile.getOriginalFilename();
		File tmpFile = new File(path);
		multipartFile.transferTo(tmpFile);
		return multipartFile.getOriginalFilename();
	}
	*/
	
	
//	@PostMapping("/file-upload")
//	public int fileUpload(@ModelAttribute FileInfoVO fileInfo) throws IllegalStateException, IOException {
//		return fileInfoService.insertFileInfo(fileInfo);
//	}
	
	@Autowired
	private FileUtil fileUtil;	// 원래는 서비스에서 해줘야함~
	
	@PostMapping("/file-upload")
	public String fileUpload2(@ModelAttribute FileInfoVO fileInfo) throws IllegalStateException, IOException {
		log.debug("upload file=>{}", fileInfo.getFile1());
		log.debug("upload file size=>{}", fileInfo.getFile1().getSize());
		return fileUtil.saveFile(fileInfo.getFile1());
	}
	
}
