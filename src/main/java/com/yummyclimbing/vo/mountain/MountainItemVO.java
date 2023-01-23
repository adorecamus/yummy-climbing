package com.yummyclimbing.vo.mountain;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;

import lombok.Data;

@Data
@JacksonXmlRootElement(localName="item")
public class MountainItemVO {
	private int miNum;
	private String miCredat;
	private String miLmodat;
	
	@JacksonXmlProperty(localName="aeatreason")
	private String aeatreason; // 100대산 선정 이유
	@JacksonXmlProperty(localName="areanm")
	private String areanm; // 산 지역
	@JacksonXmlProperty(localName="details")
	private String details; // 산 정보
	@JacksonXmlProperty(localName="etccourse") 
	private String etccourse; // 다른 코스
	@JacksonXmlProperty(localName="flashurl")
	private String flashurl;
	@JacksonXmlProperty(localName="mntheight") 
	private int mntheight; // 산 높이
	@JacksonXmlProperty(localName="mntncd")
	private String mntncd; // 산코드 // P.K.
	@JacksonXmlProperty(localName="mntnm")
	private String mntnm; // 산이름 unique
	@JacksonXmlProperty(localName="overview")
	private String overview; // 설명 미리보기
	@JacksonXmlProperty(localName="subnm")
	private String subnm; // 부제
	@JacksonXmlProperty(localName="tourisminf")
	private String tourisminf; // 주변관광명소 
	@JacksonXmlProperty(localName="videourl")
	private String videourl; // other path column url
}
