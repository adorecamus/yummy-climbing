package com.yummyclimbing;

import java.io.IOException;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.yummyclimbing.service.mountain.MountainInfoService;
import com.yummyclimbing.vo.mountain.MountainImgAndTrafficItemVO;
import com.yummyclimbing.vo.mountain.MountainPositionItemVO;

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
		
		int result = mountainInfoService.updateMountainInfos();
		log.debug("result=>{}",result);
		
	}
}
