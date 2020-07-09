package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;
import org.kitchen.exception.DuplicatedUserException;
import org.kitchen.exception.NoUserFoundException;
import org.kitchen.exception.UserMapperFailException;

public interface UserService {
	
	UserVO getUserById(String userId);

	UserVO getUserByEmail(String email);

	UserVO getUserByNo(Long userNo);

	Long getUserNoById(String userId);

	boolean isLegitNewUser(UserVO user);

	boolean isLegitUserId(String userId);

	boolean isLegitUserEmail(String email);

	void registerNewUser(UserVO user) throws DuplicatedUserException, UserMapperFailException;

	void sendVerificationEmail(UserVO user);

	boolean verifyEmail(String userno, String key);

	boolean activateUser(Long userNo);

	boolean modifyUser(UserVO user) throws UserMapperFailException;

	boolean deleteUser(UserVO user) throws UserMapperFailException;

	boolean deleteUserByNo(Long userNo) throws UserMapperFailException;

	List<UserVO> getTotalList();

	List<UserVO> getMailingnList();

	public List<UserVO> getProfile(String userId);
	
	List<RecipeVO> getUserRecipeList(Long userNo);
	
	UserVO tempLogin(UserVO user);

	List<UserVO> getIdAutocomplete(String result);
}