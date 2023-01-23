package com.yummyclimbing.schedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.yummyclimbing.service.mountain.MountainInfoService;
import com.yummyclimbing.service.party.PartyInfoService;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class Scheduler {

	@Autowired
	private PartyInfoService partyInfoService;
	
	@Autowired
	private MountainInfoService mountainInfoService;
	
	//소모임 모집기한 만료시 모집완료로 변경(매일 12시 0분 0초마다 실행)
	@Scheduled(cron="0 0 0 * * *")
	public void completePartyByExpdat() {	
		boolean result = partyInfoService.completePartyByExpdat();
		log.debug("result=>{}", result);
	}
	
	// 주기적 산 정보 업데이트(매월 1일 00시 30분)
	@Scheduled(cron="0 30 0 1 * *")
	public void updateMountainInfo() {
		int result = mountainInfoService.updateMountainInfo();
		log.debug("result=>{}", result);
	}
	
}