package com.yummyclimbing.controller.mountain;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.mountain.MountainInfoService;
import com.yummyclimbing.vo.mountain.MountainItemVO;

@Controller
public class MountainInfoController {

	@Autowired
	private MountainInfoService mountainInfoService;
	
	//*********** Get ***********//
	@GetMapping("/mountain") // 산 메인
	@ResponseBody
	public List<MountainItemVO> getMountainList(@RequestBody MountainItemVO mountainInfo){
		return mountainInfoService.selectMountainInfoList(mountainInfo);
	}
	
}
