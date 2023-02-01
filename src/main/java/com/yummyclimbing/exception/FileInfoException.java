package com.yummyclimbing.exception;

@SuppressWarnings("serial")
public class FileInfoException extends RuntimeException {

	public FileInfoException(String message) {
		super(message);
	}

	public FileInfoException(String message, Throwable cause) {
		super(message, cause);
	}
}