package com.yummyclimbing;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.io.IOException;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import com.yummyclimbing.mapper.community.CommunityBoardMapper;
import com.yummyclimbing.vo.community.CommunityBoardVO;
import com.yummyclimbing.vo.community.Criteria;

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
		
//		int result = mountainInfoService.updateMountainInfos();
//		log.debug("result=>{}",result);
	}
}
