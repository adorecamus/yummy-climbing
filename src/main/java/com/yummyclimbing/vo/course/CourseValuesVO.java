package com.yummyclimbing.vo.course;

import java.util.List;

import lombok.Data;

@Data
public class CourseValuesVO {
	List<CourseAttributeVO> attributes;
	List<CouresGeometryVO> geometry;
}
