package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.UserVO;
import org.kitchen.exception.DuplicatedUserException;
import org.kitchen.exception.NoUserFoundException;
import org.kitchen.exception.UserMapperFailException;

public interface UserService {
	
	UserVO getUserById(String userId) throws NoUserFoundException;

	UserVO getUserByEmail(String email) throws NoUserFoundException;

	UserVO getUserByNo(Long userNo) throws NoUserFoundException;

	Long getUserNoById(String userId) throws NoUserFoundException;

	boolean isLegitNewUser(UserVO user) throws DuplicatedUserException;

	boolean isLegitUserId(String userId);

	boolean isLegitUserEmail(String email);

	void registerNewUser(UserVO user) throws DuplicatedUserException, UserMapperFailException;

	void sendVerificationEmail(UserVO user);

	boolean verifyEmail(String userno, String key) throws NoUserFoundException;

	boolean activateUser(Long userNo) throws NoUserFoundException;

	boolean modifyUser(UserVO user) throws NoUserFoundException, UserMapperFailException;

	boolean deleteUser(UserVO user) throws NoUserFoundException, UserMapperFailException;

	boolean deleteUserByNo(Long userNo) throws NoUserFoundException, UserMapperFailException;

	List<UserVO> getTotalList() throws NoUserFoundException;

	List<UserVO> getMailingnList() throws NoUserFoundException;

	public List<UserVO> getProfile(String userId);
}