package com.hxd.exception;

import org.apache.shiro.authc.AuthenticationException;

public class UserLockException extends AuthenticationException {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5748416839716208011L;
	
	public UserLockException() {
		super();
	}

	public UserLockException(String message, Throwable cause) {
		super(message, cause);
	}

	public UserLockException(String message) {
		super(message);
	}

	public UserLockException(Throwable cause) {
		super(cause);
	}
}
