package com.yummyclimbing.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.yummyclimbing.service.FileInfoService;
import com.yummyclimbing.vo.FileInfoVO;

@RestController
public class FileInfoController {

	/*
	@PostMapping("/file-upload")
	public String fileUpload(@RequestPart("file") MultipartFile multipartFile) throws IllegalStateException, IOException {
		String path = "C:/java-works/upload/" + multipartFile.getOriginalFilename();
		File tmpFile = new File(path);
		multipartFile.transferTo(tmpFile);
		return multipartFile.getOriginalFilename();
	}
	*/
	
	@Autowired
	private FileInfoService fileInfoService;
	
	@PostMapping("/file-upload")
	public int fileUpload(@ModelAttribute FileInfoVO fileInfo) throws IllegalStateException, IOException {
		return fileInfoService.insertFileInfo(fileInfo);
	}
	
}
