package org.kitchen.domain;

import org.kitchen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ProfileDTOFactory {

	
	static UserService userService;
	
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	public static SimpleProfileDTO getSimpleProfile(UserVO user) {
		SimpleProfileDTO simpleProfile = new SimpleProfileDTO(user);
		simpleProfile.setFollowers(userService.countFollower(user.getUserNo()));
		simpleProfile.setFollowings(userService.countFollowing(user.getUserNo()));
		simpleProfile.setRecipeCount(userService.countUserRecipeList(user.getUserNo()));
		return simpleProfile;
	}
	
	public static ProfileDTO getProfile(UserVO user) {
		ProfileDTO profile = new ProfileDTO(user);
		profile.setRecipes(userService.getUserRecipeList(user.getUserNo()));
		profile.setFollowers(userService.countFollower(user.getUserNo()));
		return profile;
	}
	
	public static ProfileDTO getProfile(UserVO user, Long visitorNo) {
		ProfileDTO profile = new ProfileDTO(user);
		profile.setRecipes(userService.getUserRecipeList(user.getUserNo()));
		profile.setFollowers(userService.countFollower(user.getUserNo()));
		profile.setFollowing(userService.countFollower(user.getUserNo(), visitorNo)==1);
		System.out.println("@@@@@@"+profile.following);
		return profile;
	}

}
