package org.kitchen.mapper;

import java.util.List;

import org.kitchen.domain.Criteria_k;
import org.kitchen.domain.UserVO;

public interface UserMapper_k {
	public int insert(UserVO user);

	public List<UserVO> getInfobyId(Criteria_k cri);


	public List<UserVO> getProfile(String userId); 

}
