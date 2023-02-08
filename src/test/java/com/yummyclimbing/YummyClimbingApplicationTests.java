package com.yummyclimbing;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.io.IOException;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.yummyclimbing.mapper.community.CommunityBoardMapper;
import com.yummyclimbing.service.mountain.MountainInfoService;
import com.yummyclimbing.vo.community.CommunityBoardVO;
import com.yummyclimbing.vo.community.Criteria;
import com.yummyclimbing.vo.mountain.KakaoMapResponseVO;

import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
class YummyClimbingApplicationTests {

	@Autowired
	private MountainInfoService mountainInfoService;
	
	@Test
	void contextLoads() throws IOException {
//		List<MountainImgAndTrafficItemVO> result = mountainInfoService.getMountainImgAndTrafficInfoList();
//		List<MountainPositionItemVO> result = mountainInfoService.getMountainPositionInfoList();
//		int result= mountainInfoService.insertMountainInfo();
		KakaoMapResponseVO kr = mountainInfoService.getKakaoMapInfo("도봉산");
		
//		int result = mountainInfoService.updateMountainInfos();
//		log.debug("result=>{}",result);
	}
}
