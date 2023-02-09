package com.yummyclimbing;


import java.io.IOException;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.yummyclimbing.service.mountain.MountainInfoService;
import com.yummyclimbing.vo.mountain.KakaoMapResponseVO;

import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
class YummyClimbingApplicationTests {

//	@Autowired
//	private MountainInfoService mountainInfoService;
	
	@Test
	void contextLoads() throws IOException {
//		List<MountainImgAndTrafficItemVO> result = mountainInfoService.getMountainImgAndTrafficInfoList();
//		List<MountainPositionItemVO> result = mountainInfoService.getMountainPositionInfoList();
//		int result = mountainInfoService.insertMountainInfo();
//		KakaoMapResponseVO kr = mountainInfoService.getKakaoMapInfo("도봉산");
		
//		int result = mountainInfoService.updateMountainInfos();
//		log.debug("result=>{}",result);
	}
}
