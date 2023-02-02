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

	@Autowired
	private CommunityFileInfoService cfService;
	@Autowired
	private FileUtil fileUtil;
	
	@PostMapping("/community-board-file")
	public String fileUpload(@ModelAttribute CommunityFileInfoVO cfVO) throws IllegalStateException, IOException {
		log.debug("upload file=>{}", cfVO.getFile1());
		log.debug("upload file size=>{}", cfVO.getFile1().getSize());
		return fileUtil.saveFile(cfVO.getFile1());
	}
	
}
