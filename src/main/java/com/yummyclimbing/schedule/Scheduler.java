package com.yummyclimbing.schedule;

import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.Date;
import java.util.List;

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
	public void updatePartyExpired() {	
		Instant now = Instant.now();
		Date date = Date.from(now);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String expdat = sdf.format(date);
		//오늘 날짜가 만료일인 소모임을 모집완료로 변경
		int result = partyInfoService.updatePartyExpired(expdat);
		log.debug("result=>{}", result);
	}
//	
//	// 주기적 산 정보 업데이트(매월 1일 00시 30분) 업데이트 코드 오류로 주석처리
//	@Scheduled(cron="0 5 6 * * *")
//	public void updateMountainInfo() {
//		int result = mountainInfoService.updateMountainInfoList();
//		log.debug("result=>{}", result);
//	}	
	
}