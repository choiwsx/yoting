package org.kitchen.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SimpleProfileDTO {
	
	private Long userNo;
	private String userId;
	private String nickName;
	private String profilePhoto;
	private int followers;
	private int followings;
	
	public SimpleProfileDTO(UserVO user) {
		userNo = user.getUserNo();
		userId = user.getUserId();
		nickName = user.getNickName();
		profilePhoto = user.getProfilePhoto();
	}
}
