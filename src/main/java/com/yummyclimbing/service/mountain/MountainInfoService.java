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
	@Value("${mountain.num_of_rows}")
	private int numOfRows; // 산개수(100개)
	@Value("${mountain.page_no}")
	private int pageNo;
	
	@Autowired
	public Rest rest; // rest template
	@Autowired
	public MountainInfoMapper mountainInfoMapper;
	
	public List<MountainItemVO> getMountainInfoList(){ // DATA.GO.KR 산정보 API 가져오기
		Map<String,Object> apiParam = new HashMap<>();
		apiParam.put("servicekey", serviceKey);
		apiParam.put("pageNo", pageNo);
		apiParam.put("numOfRows", numOfRows);
		
		MountainResponseVO response = rest.getData(mountainURL, MountainResponseVO.class, apiParam);
		return response.getBody().getItems();
//		log.debug("MountainInfoList=>{}",MountainInfoList);
	}

	public List<MountainItemVO> selectMountainInfoList(MountainItemVO mountainInfo){
		return mountainInfoMapper.selectMountainInfoList(mountainInfo);
	}
	
	public int insertMountainInfoList(){ // insert list
		List<MountainItemVO> mountainInfoList = getMountainInfoList();
		
		if(mountainInfoList!=null && mountainInfoList.size()==numOfRows) {
			return mountainInfoMapper.insertMountainInfoList(mountainInfoList);
		}
		return 0;
	}
	
	public int updateMountainInfoList(){ // update list
		List<MountainItemVO> mountainInfoList = getMountainInfoList();
		
		if(mountainInfoList!=null && mountainInfoList.size()==numOfRows) {
			return mountainInfoMapper.updateMountainInfoList(mountainInfoList);
		}
		return 0;
	}
	
	public int deleteMountainInfoList() {
		return mountainInfoMapper.deleteMountainInfoList();
	}
}
