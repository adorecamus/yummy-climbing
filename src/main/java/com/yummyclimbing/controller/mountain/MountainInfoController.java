package com.yummyclimbing.controller.mountain;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.mountain.MountainInfoService;
import com.yummyclimbing.vo.mountain.MountainInfoItemVO;

@Controller
public class MountainInfoController {

	@Autowired
	private MountainInfoService mountainInfoService;
	
	//*********** Get ***********//
	@GetMapping("/mountain") // 산 메인
	@ResponseBody
	public List<MountainInfoItemVO> getMountainList(@ModelAttribute MountainInfoItemVO mountainInfo){
		return mountainInfoService.selectMountainInfoList(mountainInfo);
	}
	
	@GetMapping("/mountain/{mntnm}")
	@ResponseBody
	public MountainInfoItemVO getMountainInfo(@PathVariable("mntnm") String mntnm) {
		return mountainInfoService.selectMountainInfoByMntnm(mntnm);
	}
	
	@GetMapping("/mountain/recommended")
	@ResponseBody
	public List<MountainInfoItemVO> getRecommendedMountainList(){
		return mountainInfoService.selectRecommendedMountainInfoList();
	}
	
}
