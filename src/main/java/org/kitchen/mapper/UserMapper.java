package org.kitchen.mapper;

import java.util.List;

import org.kitchen.domain.UserVO;

public interface UserMapper {
	public int register(UserVO user);
	public UserVO get(UserVO user);
	public UserVO get(String userId);
	public UserVO getByUserNo(Long userNo);
	public boolean modify(UserVO user);
	public boolean remove(UserVO user);
	public List<UserVO> getList(UserVO user);
	public List<UserVO> getTotalList();
}
