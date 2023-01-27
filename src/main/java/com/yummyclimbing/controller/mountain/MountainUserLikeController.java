package com.yummyclimbing.controller.mountain;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.mountain.MountainUserLikeService;
import com.yummyclimbing.vo.mountain.MountainUserLikeVO;

@Controller
public class MountainUserLikeController {

    //-----Dependency injection----///
	@Autowired
	private MountainUserLikeService mountainUserLikeService;
	
	@GetMapping("/mountain-like/{miNum}")
	@ResponseBody
	public int getMountainUserLikeEnabledCount(@PathVariable int miNum) {
		MountainUserLikeVO mountainUserLike = new MountainUserLikeVO();
		mountainUserLike.setMiNum(miNum);
		return mountainUserLikeService.getMountainUserLikeEnabledCount(mountainUserLike);
	}
	
	@PostMapping("/mountain-like")
	@ResponseBody
	public boolean checkMountainUserLikeInfo(MountainUserLikeVO mountainUserLike) {
		return mountainUserLikeService.checkMountainUserLikeInfo(mountainUserLike);
	}
	
}
