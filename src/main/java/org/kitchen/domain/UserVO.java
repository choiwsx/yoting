package org.kitchen.domain;

import org.kitchen.enums.UserStatus;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserVO {
	private Long userNo;
	private String userId;
	private String userPwd;
	private String email;
	private boolean emailAuth;
	private String nickName;
	private String profilePhoto;
	private String webUrl;
	private String bio; // ¼Ò°³±Û
	private boolean emailSub;
	private boolean privacy;
	private UserStatus status;
	
	public UserVO setNewProfile(String nickName, String bio, boolean privacy) {
		this.nickName = nickName;
		this.bio = bio;
		this.privacy = privacy;
		return this;
	}
}
