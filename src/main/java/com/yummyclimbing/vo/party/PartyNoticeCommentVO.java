package com.yummyclimbing.vo.party;

import lombok.Data;

@Data
public class PartyNoticeCommentVO {

	private int pncNum;
	private String pncComment;
	private String pncCredat;
	private String pncLmodat;
	private int pncActive;
	
	private int piNum;
	private int pbnNum;
	private int uiNum;
	private String uiNickname;
}
