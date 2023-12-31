package com.yummyclimbing.controller.community;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class FileUploadController {
	
	@PostMapping("/multi-file")
	public String multiFileUpload(@RequestParam("multiFile") List<MultipartFile> multiFileList, @RequestParam String fileContent, HttpServletRequest request) {
		
		// 받아온 것 출력 확인
		log.debug("multiFileList=>{}", multiFileList);
		log.debug("fileContent=>{}", fileContent);
		
		// path 가져오기
		String path = request.getSession().getServletContext().getRealPath("resources");
		String root = path + "\\" + "uploadFiles";
		
		File fileCheck = new File(root);
		
		if(!fileCheck.exists()) fileCheck.mkdirs();
		
		List<Map<String, String>> fileList = new ArrayList<>();
		
		for(int i = 0; i < multiFileList.size(); i++) {
			String originFile = multiFileList.get(i).getOriginalFilename();
			String ext = originFile.substring(originFile.lastIndexOf("."));
			String changeFile = UUID.randomUUID().toString() + ext;
			
			Map<String, String> map = new HashMap<>();
			map.put("originFile", originFile);
			map.put("changeFile", changeFile);
			
			fileList.add(map);
		}
		
		// 파일 업로드
		try {
			for(int i = 0; i < multiFileList.size(); i++) {
				File uploadFile = new File(root + "\\" + fileList.get(i).get("changeFile"));
				multiFileList.get(i).transferTo(uploadFile);
			}
			
			log.debug("다중 파일 업로드 성공");
			
		} catch (IllegalStateException | IOException e) {
			log.debug("다중 파일 업로드 실패");
			// 만약 업로드 실패하면 파일 삭제
			for(int i=0; i<multiFileList.size(); i++) {
				new File(root + "\\" + fileList.get(i).get("changeFile")).delete();
			}		
			e.printStackTrace();
		}		
		return "result";
		}
	}
