package org.kitchen.exception;

public class NoUserFoundException extends Exception {
	public NoUserFoundException() {
		super("찾는 유저가 없습니다.");
	}

}
