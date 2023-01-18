package com.yummyclimbing.schedule;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class Scheduler {

	/*
	@Autowired
	private BoxOfficeService boxOfficeService;
	
	//cron = "초 분 시 일 월 주"
	@Scheduled(cron="0 10 13 * * *")	
	public void dailyBoxOffice() {
		List<DailyBoxOfficeVO> boxOfficeList = boxOfficeService.getBoxOffices(1);
		int result = boxOfficeService.insertBoxOffice(boxOfficeList);
		log.debug("result => {}", result);
	}
	*/
	
}