package com.yummyclimbing.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.yummyclimbing.mapper.FileInfoMapper;
import com.yummyclimbing.vo.FileInfoVO;

@Service
@PropertySource("classpath:env.properties")
public class FileInfoService {
	
	@Value("${file.path}")
	private String filePath;

	@Autowired
	private FileInfoMapper fileInfoMapper;
	
	public List<FileInfoVO> selectFileInfos() {
		return fileInfoMapper.selectFileInfoList();
	}
	
	public int insertFileInfo(FileInfoVO fileInfo) throws IllegalStateException, IOException {
		if(fileInfo.getFile() == null) {
			throw new RuntimeException("파일을 업로드하지 않았습니다.");
		}
		MultipartFile multipartFile = fileInfo.getFile();
		String fiName = multipartFile.getOriginalFilename();
		String fiPath = filePath + UUID.randomUUID().toString();
		fileInfo.setFiName(fiName);
		fileInfo.setFiPath(fiPath);
		File tmpFile = new File(fiPath);
		multipartFile.transferTo(tmpFile);
		int result = fileInfoMapper.insertFileInfo(fileInfo);
//		fileInfo.setFiName(null);
		result += fileInfoMapper.insertFileInfo(fileInfo);
		return result;
	}
	
}
