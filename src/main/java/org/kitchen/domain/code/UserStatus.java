package org.kitchen.domain.code;

public enum UserStatus {
	ACTIVE('1'),
	PENDING('2'),
	SUSPENDED('3');
	
	private final char code;
	
	private UserStatus(char code) {
		this.code =code;
	}
	public char getCode() {
		return this.code;
	}
}
