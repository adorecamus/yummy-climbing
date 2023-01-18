package com.yummyclimbing.vo.board;

import lombok.Data;

@Data
public class BoardLikeVO {

	private int blNum; // 게시글 좋아요 번호 (기본키)
	private int biNum; // 게시글 번호(외래키)
	private int uiNum; // 유저 번호 (외래키)
	private int blCheck; // 좋아요 (눌렀을 경우 1, 아니면 0)
}
