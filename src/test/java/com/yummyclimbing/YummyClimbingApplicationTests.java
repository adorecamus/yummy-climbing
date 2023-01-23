package com.yummyclimbing;

import java.io.IOException;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.yummyclimbing.service.mountain.MountainInfoService;

import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
class YummyClimbingApplicationTests {

	@Autowired
	private MountainInfoService mountainInfoService;
	
	@Test
	void contextLoads() throws IOException {
		int result = mountainInfoService.updateMountainInfo();
		log.debug("result=>{}",result);
	}
}
