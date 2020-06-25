package org.kitchen.enums;

public enum UserStatus implements CodeEnum {
	ACTIVE("1"),
	PENDING("2"),
	SUSPENDED("3");
	
	public final String code;
	
	private UserStatus(String code) {
		this.code = code;
	}
	
	public String getCode() {
		return this.code;
	}
	

}
