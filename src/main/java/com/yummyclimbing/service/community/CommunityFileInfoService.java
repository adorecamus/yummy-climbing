package com.yummyclimbing.service.community;

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
import com.yummyclimbing.mapper.community.CommunityFileInfoMapper;
import com.yummyclimbing.vo.FileInfoVO;
import com.yummyclimbing.vo.community.CommunityFileInfoVO;

@Service
@PropertySource("classpath:env.properties")
public class CommunityFileInfoService {
		
	@Value("${file.path}")
	private String filePath;

	@Autowired
	private CommunityFileInfoMapper cfMapper;
	
	public List<CommunityFileInfoVO> selectFileInfos(int cbNum) {
		return cfMapper.selectFileList(cbNum);
	}
	
	public int insertFileInfo(CommunityFileInfoVO cfVO) throws IllegalStateException, IOException {
		if(cfVO.getFile1() == null) {
			throw new RuntimeException("파일을 업로드하지 않았습니다.");
		}
		MultipartFile multipartFile = cfVO.getFile1();
		String cfName = multipartFile.getOriginalFilename();
		String cfPath = filePath + UUID.randomUUID().toString();
		cfVO.setCfName(cfName);
		cfVO.setCfPath1(cfPath);
		cfVO.setCfPath2(cfPath);
		cfVO.setCfPath3(cfPath);
		File tmpFile = new File(cfPath);
		multipartFile.transferTo(tmpFile);
		int result = cfMapper.insertFile(cfVO);
//		fileInfo.setFiName(null);
		result += cfMapper.insertFile(cfVO);
		return result;
	}
}
