package org.kitchen.exception;

public class UserMapperFailException extends Exception {
	public UserMapperFailException() {
		super("유저sql매퍼실패");
	}
}
