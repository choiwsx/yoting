package org.kitchen.domain;

import org.kitchen.service.RecipeService;
import org.kitchen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ModelDTOFactory {

	
	static UserService userService;
	static RecipeService recipeService;
	
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	@Autowired
	public void setRecipeService(RecipeService recipeService) {
		this.recipeService = recipeService;
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
	
	public static SimpleRecipeDTO getSimpleRecipe(RecipeVO recipe) {
		if(recipe==null||recipeService.get(recipe.getRno())==null) return null;
		SimpleRecipeDTO simpleRecipe = new SimpleRecipeDTO(recipe, userService.getNickNameByNo(recipe.getUserNo()));
		return simpleRecipe;
	}

}
