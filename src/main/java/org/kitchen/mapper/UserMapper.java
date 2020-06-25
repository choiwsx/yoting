package org.kitchen.mapper;

import java.util.List;

import org.kitchen.domain.UserVO;
import org.kitchen.domain.code.UserStatus;

public interface UserMapper {
	public int insert(UserVO user);
	//public UserVO get(UserVO user);
	public UserVO selectById(String userId);
	public UserVO selectByEmail(String email);
	public UserVO selectByNo(Long userNo);
	public int getNoById(String userId);
	public boolean isPrivate(String userId);
	public UserStatus getStatus(String userId);
	public int update(UserVO user);
	public int delete(UserVO user);
	public int deleteByNo(Long userNo);
	public int deleteById(String userId);
	//public List<UserVO> getList(UserVO user); 뭘로 list받아야할지 생각
	public List<UserVO> getMailingList();
	public List<UserVO> getTotalList();
	
	public int test(boolean b);
	public List<Boolean> testcheck();
}
