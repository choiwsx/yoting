package org.kitchen.mapper;

import java.util.List;

import org.kitchen.domain.UserVO;
import org.kitchen.enums.UserStatus;

public interface UserMapper_k {
	public int insert(UserVO user);

	public UserVO selectById(String userId);
	public UserVO selectByEmail(String email);
	public UserVO selectByNo(Long userNo);
	public int getNoById(String userId);
	
	public boolean isLegitId(String userId);
	public boolean isLegitEmail(String email);
	
	public boolean isPrivate(String userId);
	
	public int update(UserVO user);
	
	public int delete(UserVO user);
	public int deleteByNo(Long userNo);
	public int deleteById(String userId);

	public List<UserVO> getMailingList();
	public List<UserVO> getTotalList();
	
	public List<UserVO> getInfobyId(); 

}
