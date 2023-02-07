package com.yummyclimbing.service.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.community.CommunityBoardFileMapper;
import com.yummyclimbing.vo.community.CommunityBoardFileVO;

@Service
public class CommunityBoardFileService {

	@Autowired
	private CommunityBoardFileMapper cfMapper;
	
	public List<CommunityBoardFileVO> selectFileInfos(int cbNum) {
		return cfMapper.selectFileList(cbNum);
	}
	
//	public int insertFileInfo(CommunityBoardFileVO cfVO) throws IllegalStateException, IOException {
//		if(cfVO.getFile1() == null) {
//			throw new RuntimeException("파일을 업로드하지 않았습니다.");
//		}
//		MultipartFile multipartFile = cfVO.getFile1();
//		String cfName = multipartFile.getOriginalFilename();
//		String cfPath = filePath + UUID.randomUUID().toString();
//		cfVO.setCfName(cfName);
//		cfVO.setCfPath1(cfPath);
//		cfVO.setCfPath2(cfPath);
//		cfVO.setCfPath3(cfPath);
//		File tmpFile = new File(cfPath);
//		multipartFile.transferTo(tmpFile);
//		int result = cfMapper.insertFile(cfVO);
//		return result;
//	}
}
