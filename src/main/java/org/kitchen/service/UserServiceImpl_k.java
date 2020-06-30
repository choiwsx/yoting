package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.Criteria_k;
import org.kitchen.domain.UserVO;
import org.kitchen.mapper.UserMapper_k;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class UserServiceImpl_k implements UserService_k {
	
	@Setter(onMethod_ = @Autowired)
	private UserMapper_k mapper;

	@Override
	public List<UserVO> getInfobyId(Criteria_k cri) {
		return mapper.getInfobyId(cri);
	}

	@Override
	public List<UserVO> getProfile(String userId) {
		return mapper.getProfile(userId);
	}



}
