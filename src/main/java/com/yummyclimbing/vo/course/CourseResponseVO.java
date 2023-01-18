package com.yummyclimbing.vo.course;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class CourseResponseVO {
	private String displayFieldName;
	private CourseAliasesVO fieldAliases;
	private String geometryType;
	//private List<CourseSpatialReferenceVO> spatialReference;
	private List<CourseFieldsVO> fields;
	private List<CourseValuesVO> features;
}
