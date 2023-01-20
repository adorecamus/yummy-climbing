package com.yummyclimbing.config;

import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.web.client.RestTemplate;

import lombok.AllArgsConstructor;

@Configuration
public class BeanConfig {
	
	@Bean
	public RestTemplate restTemplate() {
		return new RestTemplate();
	}

	@Bean
	public PropertiesFactoryBean envProperties() {
		PropertiesFactoryBean bean = new PropertiesFactoryBean();
		bean.setLocation(new ClassPathResource("/env.properties"));
		return bean;
	}
	
}
