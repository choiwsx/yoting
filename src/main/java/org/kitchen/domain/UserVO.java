package org.kitchen.domain;

import org.kitchen.enums.UserStatus;

import lombok.Data;

@Data
public class UserVO {
	private Long userNo;
	private String userId;
	private String userPwd;
	private String email;
	private boolean emailAuth;
	private String nickName;
	private String profilePhoto;
	private String webUrl;
	private String bio; //�Ұ���
	private boolean emailSub;
	private boolean privacy;
	private UserStatus status;
}
