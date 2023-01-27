package com.yummyclimbing.vo.mountain;

import lombok.Data;

@Data
public class MountainCommentVO {
	private int mcNum; // PK
	private int miNum; // FOREIGN KEY
	private int uiNum; // FOREIGN KEY
	private String mcComment; // 댓글 내용
	private int mcActive; // 활성화 여부
	private String mcCredat; // 작성일자
	private String mcLmodat; // 수정일자
}
