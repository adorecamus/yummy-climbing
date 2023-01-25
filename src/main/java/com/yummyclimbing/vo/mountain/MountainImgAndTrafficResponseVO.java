package com.yummyclimbing.vo.mountain;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;

import lombok.Data;

@Data
@JacksonXmlRootElement(localName="response")
public class MountainImgAndTrafficResponseVO {
	@JacksonXmlProperty(localName="header")
	private MountainHeaderVO header;
	@JacksonXmlProperty(localName="body")
	private MountainImgAndTrafficBodyVO body;
}
