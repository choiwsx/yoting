package org.kitchen.service;

import java.sql.SQLException;

import org.kitchen.domain.UserVO;
import org.kitchen.exception_h.UserDuplicatedException;
import org.kitchen.mapper.UserMapper;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService_h {

	private UserMapper mapper;
	
	@Override
	public UserVO registerNewUser(UserVO user) throws UserDuplicatedException {
		// TODO Auto-generated method stub
		if(idExists(user.getUserId()) || emailExists(user.getEmail())) {
			throw new UserDuplicatedException();
		}
		try {
			mapper.insert(user);
			return user;
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			log.info("유저서비스임플#########sql integrity 문제로 가입실패");
		}
		return null;
	}

	@Override
	public boolean idExists(String userId) {
		// TODO Auto-generated method stub
		return mapper.isLegitId(userId);
	}

	@Override
	public boolean emailExists(String email) {
		// TODO Auto-generated method stub
		return mapper.isLegitEmail(email);
	}

	@Override
	public UserVO modifyUser(UserVO user) {
		// TODO Auto-generated method stub
		try {
			mapper.update(user);
			return user;
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			log.info("유저서비스임플#########sql integrity 문제로 업뎃실패");
		}
		return null;
	}

	@Override
	public boolean deleteUser(UserVO user) {
		// TODO Auto-generated method stub
		try {
			mapper.delete(user);
			return true;
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			log.info("유저서비스임플#########sql integrity 문제로 업뎃실패");
		}
		return false;
	}

}
