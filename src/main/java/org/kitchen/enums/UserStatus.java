package org.kitchen.enums;

import org.apache.ibatis.type.MappedTypes;
import org.kitchen.handler.CodeEnumTypeHandler;

import lombok.Getter;

public enum UserStatus implements CodeEnum {
	ZERO("0"),
	PENDING("1"),
	ACTIVE("2"),
	SUSPENDED("3"),
	INVALID("4"),
	DELETED("5");
	
	@Getter
	public final String status;
	
	private UserStatus() {
		status="1";
	}
	
	private UserStatus(String status) {
		this.status = status;
	}
	
	public String getCode() {
		return this.status;
	}
	
	@MappedTypes(UserStatus.class)
    public static class TypeHandler extends CodeEnumTypeHandler<UserStatus> {
        public TypeHandler() {
            super(UserStatus.class);
        }
    }

}
