package org.kitchen.domain;

import lombok.Data;

@Data
public class UserVO {
	private Long userNo;
	private String userId;
	private String userPwd;
	private String email;
	private char emailAuth;
	private String nickName;
	private String profilePhoto;
	private String webUrl;
	private String bio; //�Ұ���
	private char emailSub;
	private char privacy;
	private char status;
}
