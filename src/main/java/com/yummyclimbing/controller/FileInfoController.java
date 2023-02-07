package com.yummyclimbing.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
	public String fileUpload2(FileInfoVO fileInfo) throws IllegalStateException, IOException {
		//multipartRequest.setCharacterEncoding("utf-8");
		//MultipartHttpServletRequest multipartRequest
		log.debug("fileInfo=>{}",fileInfo.getFiles().get(0));
//		log.debug("upload file=>{}", fileInfo.getFiles());
//		log.debug("upload file size=>{}", fileInfo.getFiles().size());
		
//		for(int i=0;i<fileInfo.getFiles().size();i++) {
//			String str = fileUtil.saveFile(fileInfo.getFiles().get(i));
//			fileNames.add(str);
//		}
		
		return null;
	}
	
}
