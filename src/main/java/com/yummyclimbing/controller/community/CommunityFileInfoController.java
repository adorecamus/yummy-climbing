package com.yummyclimbing.controller.community;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.yummyclimbing.service.community.CommunityFileInfoService;
import com.yummyclimbing.util.FileUtil;
import com.yummyclimbing.vo.community.CommunityFileInfoVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class CommunityFileInfoController {

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
	private CommunityFileInfoService cfService;
	
//		@PostMapping("/file-upload")
//		public int fileUpload(@ModelAttribute FileInfoVO fileInfo) throws IllegalStateException, IOException {
//			return fileInfoService.insertFileInfo(fileInfo);
//		}
	
	@Autowired
	private FileUtil fileUtil;
	
	@PostMapping("/community-board-file/{cbNum}")
	public String fileUpload2(@ModelAttribute CommunityFileInfoVO cfVO, @PathVariable("cbNum")int cbNum) throws IllegalStateException, IOException {
		cfVO.setCbNum(cbNum);
		log.debug("upload file=>{}", cfVO.getFile1());
		log.debug("upload file size=>{}", cfVO.getFile1().getSize());
		return fileUtil.saveFile(cfVO.getFile1());
	}
	
}
