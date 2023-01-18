package com.yummyclimbing.vo.party;

import lombok.Data;

@Data
public class PartyUserLikeVO {

	private int pulNum;			//유저가 좋아요 한 소모임 기본키(프라임키)
	private String pulCredat;	//유저가 좋아요 한 날짜
	private int uiNum;			//유저 번호(외래키)
	private int piNum;			//소모임 번호(외래키)
}
