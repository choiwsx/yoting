package org.kitchen.service;

import org.kitchen.domain.UserVO;
import org.kitchen.exception_h.UserDuplicatedException;

public interface UserService_h {
	UserVO registerNewUser(UserVO user) throws UserDuplicatedException;
	
	boolean idExists(String userId);
	boolean emailExists(String email);
	
	UserVO modifyUser(UserVO user);
	boolean deleteUser(UserVO user);
}