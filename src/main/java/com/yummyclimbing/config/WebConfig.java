package com.yummyclimbing.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	private static final String BASE_PATH;
	static {
		String osName = System.getProperty("os.name");
		if(osName.toUpperCase().contains("WINDOW")) {
			BASE_PATH = "file:///C:";
		} else {
			BASE_PATH = "file:/";
		}
	}
	
	// interface의 default 메소드는 선택적으로 구현 가능 (구현 안 해도 됨)
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/files/**").addResourceLocations(BASE_PATH + "/file-upload/");
	}
	
}
