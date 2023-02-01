package com.yummyclimbing.config;

import java.io.IOException;
import java.util.Date;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;

import com.yummyclimbing.exception.AuthException;
import com.yummyclimbing.vo.ErrorVO;

import lombok.extern.slf4j.Slf4j;

@ControllerAdvice
@RestController
@Slf4j
public class ExceptionHandlerAdvice {

	@ExceptionHandler(AuthException.class)
	public ResponseEntity<ErrorVO> requestHandlingServiceException(AuthException ae, WebRequest req) throws IOException {
		log.error("AuthException=>{}", ae);
		ErrorVO errorDetails = new ErrorVO(new Date(), ae.getMessage(), req.getDescription(false), "err02");
		return new ResponseEntity<>(errorDetails, HttpStatus.FORBIDDEN);
	}

}
