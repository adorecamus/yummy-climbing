package com.yummyclimbing.vo.party;

import lombok.Data;

@Data
public class PartyInfoVO {

	private int piNum;				//소모임 넘버(프라임키)
	private String piName;			//소모임 이름
	private String piCredat;		//소모임 생성일자
	private String piExpdat;		//소모임 만료일자
	private String piMeetingTime;	//소모임 모임일자
	private int piMemberCnt;		//소모임 멤버수
	private int miNum;				//산 번호(외래키)
	private int uiNum;				//유저 번호(외래키)
	private int piActive;				//소모임 생성 시 1 -> 삭제할 경우 0
	private String miName;			//산 이름(외래키)
	
}