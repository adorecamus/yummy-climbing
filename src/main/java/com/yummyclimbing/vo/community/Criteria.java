package com.yummyclimbing.vo.community;

import lombok.Data;

@Data
public class Criteria {

	private int pageNum;	// 현재 페이지
	private int amount;		// 한 페이지당 출력할 게시물 개수
	private int skip;		// 스킵할 게시물 개수
	
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.skip = (pageNum-1)*amount;
	}
	
}
