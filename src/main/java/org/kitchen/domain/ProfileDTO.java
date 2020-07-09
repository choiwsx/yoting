package org.kitchen.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProfileDTO {
	UserVO user;
	int followers;
	boolean following;
	List<RecipeVO> recipes;

	public ProfileDTO() {
		
	}
	
	public ProfileDTO(UserVO user) {
		setUser(user);
	}
	
	public ProfileDTO(UserVO user, List<RecipeVO> recipes) {
		setUser(user);
		this.recipes=recipes;
	}
	
	public void setUser(UserVO user) {
		user.setUserPwd(null);
		this.user=user;
	}
}
