package com.yummyclimbing.vo.mountain;

import lombok.Data;

@Data
public class KakaoMapMetaVO {
	private KakaoSameNameVO same_name;
    private int pageable_count;
    private int total_count;
    private boolean is_end;
}
