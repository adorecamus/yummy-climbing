package com.yummyclimbing.controller.mountain;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yummyclimbing.service.mountain.MountainCommentService;
import com.yummyclimbing.vo.mountain.MountainCommentVO;

@Controller
public class MountainCommentController {
	
	@Autowired
	MountainCommentService mountainCommentService ;
	
	@GetMapping("/mountain-comment/{miNum}")
	@ResponseBody
	public List<MountainCommentVO> selectMountainCommentListAndUser(@PathVariable("miNum") int miNum){
		return mountainCommentService.selectMountainCommentListAndUser(miNum);
	}
	
}
