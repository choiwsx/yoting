package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.UserVO;
import org.kitchen.exception_h.DuplicatedUserException;
import org.kitchen.exception_h.NoUserFoundException;

public interface UserService_h {
	UserVO getUserById(String userId) throws NoUserFoundException;
	UserVO getUserbyEmail(String email) throws NoUserFoundException;
	UserVO getUserByNo(Long userNo) throws NoUserFoundException;
	Long getUserNoById(String userId) throws NoUserFoundException;
	
	void registerNewUser(UserVO user) throws DuplicatedUserException;
	
	boolean isLegitUserId(String userId);
	boolean isLegitUserEmail(String email);
	
	UserVO modifyUser(UserVO user) throws NoUserFoundException;
	boolean deleteUser(UserVO user) throws NoUserFoundException;
	
	List<UserVO> getTotalList();
	List<UserVO> getMailingnList();
}