package org.kitchen.domain;

import lombok.Data;

@Data
public class UserVO {
	private Long userNo;
	private String userId;
	private String userPwd;
	private String email;
	private String emailAuth;
	private String nickName;
	private String profilePhoto;
	private String webUrl;
	private String bio; //¼Ò°³±Û
	private String emailSub;
	private boolean privacy;
	private String status;
}
