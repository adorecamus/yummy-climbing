package com.yummyclimbing.vo;

import lombok.Data;

@Data
public class ResponseVO {

	private boolean result;	// 서비스 처리 결과
	private String msg;		// 화면에 보낼 메시지
	private String url;		// 화면에서 이동할 주소
	
}
