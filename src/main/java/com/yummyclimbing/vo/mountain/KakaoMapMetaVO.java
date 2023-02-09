package com.yummyclimbing.vo.mountain;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class KakaoMapMetaVO {
	private KakaoSameNameVO same_name;
    private int pageable_count;
    private int total_count;
    
    @JsonProperty("is_end")
    private boolean is_end;
}
