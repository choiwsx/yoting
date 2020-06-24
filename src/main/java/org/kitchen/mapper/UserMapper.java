package org.kitchen.mapper;

import java.util.List;

import org.kitchen.domain.UserVO;

public interface UserMapper {
	public int insert(UserVO user);
	//public UserVO get(UserVO user);
	public UserVO selectById(String userId);
	public UserVO selectByNo(Long userNo);
	public int update(UserVO user);
	public int delete(UserVO user);
	public int deleteByNo(Long userNo);
	public int deleteById(String userId);
	//public List<UserVO> getList(UserVO user); 뭘로 list받아야할지 생각
	public List<UserVO> getTotalList();
}
