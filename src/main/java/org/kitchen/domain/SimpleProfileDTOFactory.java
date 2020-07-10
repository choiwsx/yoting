package org.kitchen.domain;

import org.kitchen.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;

public class SimpleProfileDTOFactory {
	@Autowired
	static UserMapper userMapper;
	
	public static SimpleProfileDTO getSimpleProfile(UserVO user) {
		SimpleProfileDTO simpleProfile = new SimpleProfileDTO(user);
		simpleProfile.setFollowers(userMapper.countFollower(user.getUserNo()));
		simpleProfile.setFollowings(userMapper.countFollowing(user.getUserNo()));
		return simpleProfile;
	}

}
