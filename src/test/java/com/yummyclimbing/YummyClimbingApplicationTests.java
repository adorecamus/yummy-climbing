package com.yummyclimbing;

import java.io.File;
import java.io.IOException;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import com.fasterxml.jackson.core.exc.StreamReadException;
import com.fasterxml.jackson.databind.DatabindException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.yummyclimbing.vo.course.CourseResponseVO;

import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
class YummyClimbingApplicationTests {

	@Test
	void contextLoads() throws StreamReadException, DatabindException, IOException {
		
		ObjectMapper objectMapper = new ObjectMapper();
		CourseResponseVO res = objectMapper.readValue(new File("C:/Users/Taeshin/Desktop/new/4-yummy-climbing/src/main/resources/json/PMNTN_도봉산_자운봉_113200102.json"), CourseResponseVO.class);
		
		log.debug("res=>{}",res);
	}

}
