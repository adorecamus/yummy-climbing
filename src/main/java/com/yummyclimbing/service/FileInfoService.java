package com.yummyclimbing.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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

//	public int insertFileInfo(FileInfoVO fileInfo) throws IllegalStateException, IOException {
//		if(fileInfo.getFile() == null) {
//			throw new RuntimeException("파일을 업로드하지 않았습니다.");
//		}
//		MultipartFile multipartFile = fileInfo.getFile();
//		String fiName = multipartFile.getOriginalFilename();
//		String fiPath = filePath + UUID.randomUUID().toString();
//		fileInfo.setFiName(fiName);
//		fileInfo.setFiPath(fiPath);
//		File tmpFile = new File(fiPath);
//		multipartFile.transferTo(tmpFile);
//		int result = fileInfoMapper.insertFileInfo(fileInfo);
////		fileInfo.setFiName(null);
//		result += fileInfoMapper.insertFileInfo(fileInfo);
//		return result;
//	}

	private String insertFileInfo(MultipartFile file) throws IllegalStateException, IOException {
		if (file == null) {
			return null;
		}
		String fiName = file.getOriginalFilename();
		int lastIndex = fiName.lastIndexOf("."); // lastIndexof() 뒤에서부터 찾음
		String extName = fiName.substring(lastIndex);
		String fiPath = filePath + UUID.randomUUID().toString() + extName;
		FileInfoVO fileInfo = new FileInfoVO();
		fileInfo.setFiName(fiName);
		fileInfo.setFiPath(fiPath);
		File tmpFile = new File(fiPath);
		file.transferTo(tmpFile);
		if (fileInfoMapper.insertFileInfo(fileInfo) == 1) {
			return fiPath;
		}
		return null;
	}
	
//	public List<String> insertFiles(MultiFileVO files) throws IllegalStateException, IOException {
//		List<String> filePathList = new ArrayList<>();
//		if (files.getFile1() == null) {
//			throw new RuntimeException("파일을 업로드하지 않았습니다.");
//		}
//		filePathList.add(insertFileInfo(files.getFile1()));
//		if (files.getFile2() == null) {
//			return filePathList;
//		}
//		filePathList.add(insertFileInfo(files.getFile2()));
//		if (files.getFile3() == null) {
//			return filePathList;
//		}
//		filePathList.add(insertFileInfo(files.getFile3()));
//		return filePathList;
//	}
//	
//	private List<String> checkNull(List<String> filePathList, MultipartFile file) throws IllegalStateException, IOException {
//		if (file == null) {
//			return filePathList;
//		}
//		filePathList.add(insertFileInfo(file));
//		return filePathList;
//	}

}
