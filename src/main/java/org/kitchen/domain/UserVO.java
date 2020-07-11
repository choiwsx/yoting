package org.kitchen.domain;

import org.kitchen.enums.UserStatus;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
public class UserVO {
	private Long userNo;
	private String userId;
	private String userPwd;
	private String email;
	private boolean emailAuth;
	private String nickName;
	private String profilePhoto;
	private String webUrl;
	private String bio; 
	private boolean emailSub;
	private boolean privacy;
	private UserStatus status;
	
	public UserVO setNewProfile(String nickName, String bio, boolean privacy) {
		this.nickName = nickName;
		this.bio = bio;
		this.privacy = privacy;
		return this;
	}

	public Long getUserNo() {
		return userNo;
	}

	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId.toLowerCase();
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email.toLowerCase();
	}

	public boolean isEmailAuth() {
		return emailAuth;
	}

	public void setEmailAuth(boolean emailAuth) {
		this.emailAuth = emailAuth;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getProfilePhoto() {
		return profilePhoto;
	}

	public void setProfilePhoto(String profilePhoto) {
		this.profilePhoto = profilePhoto;
	}

	public String getWebUrl() {
		return webUrl;
	}

	public void setWebUrl(String webUrl) {
		this.webUrl = webUrl;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}

	public boolean isEmailSub() {
		return emailSub;
	}

	public void setEmailSub(boolean emailSub) {
		this.emailSub = emailSub;
	}

	public boolean isPrivacy() {
		return privacy;
	}

	public void setPrivacy(boolean privacy) {
		this.privacy = privacy;
	}

	public UserStatus getStatus() {
		return status;
	}

	public void setStatus(UserStatus status) {
		this.status = status;
	}

	public UserVO(Long userNo, String userId, String userPwd, String email, boolean emailAuth, String nickName,
			String profilePhoto, String webUrl, String bio, boolean emailSub, boolean privacy, UserStatus status) {
		super();
		this.userNo = userNo;
		this.userId = userId.toLowerCase();
		this.userPwd = userPwd;
		this.email = email.toLowerCase();
		this.emailAuth = emailAuth;
		this.nickName = nickName;
		this.profilePhoto = profilePhoto;
		this.webUrl = webUrl;
		this.bio = bio;
		this.emailSub = emailSub;
		this.privacy = privacy;
		this.status = status;
	}
	
	
}
