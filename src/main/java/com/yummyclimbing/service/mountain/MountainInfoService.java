package com.yummyclimbing.service.mountain;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.mountain.MountainInfoMapper;
import com.yummyclimbing.rest.Rest;
import com.yummyclimbing.vo.mountain.MountainItemVO;
import com.yummyclimbing.vo.mountain.MountainResponseVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@PropertySource("classpath:env.properties")
public class MountainInfoService {
	@Value("${mountain.url}")
	private String mountainURL; // api service url
	@Value("${mountain.service.key}")
	private String serviceKey; // api key
	
	private final int NUM_OF_ROWS = 100; // 총 산 개수 100개(100대 산)
	private final int PAGE_NO = 1; // 1페이지에 모두 출력
	
	@Autowired
	public Rest rest; // rest template
	@Autowired
	public MountainInfoMapper mountainInfoMapper;
	
	public int getMountainInfoList(){
		Map<String,Object> param = new HashMap<>();
		param.put("servicekey", serviceKey);
		param.put("pageNo", PAGE_NO);
		param.put("numOfRows", NUM_OF_ROWS);
		
		MountainResponseVO response = rest.getData(mountainURL, MountainResponseVO.class, param);
		List<MountainItemVO> MountainInfoList = response.getBody().getItems();
//		log.debug("MountainInfoList=>{}",MountainInfoList);
		
		if(MountainInfoList!=null && MountainInfoList.size()==NUM_OF_ROWS) {
			return mountainInfoMapper.insertMountainInfoList(MountainInfoList);
		}
		return 0;
	}
}
