package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.Criteria_k;
import org.kitchen.domain.UserVO;

public interface UserService {
	
	public List<UserVO> getInfobyId(Criteria_k cri);

	public List<UserVO> getprofile();
}

