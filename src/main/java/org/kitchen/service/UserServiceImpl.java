package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.UserVO;
import org.kitchen.exception_h.DuplicatedUserException;
import org.kitchen.exception_h.NoUserFoundException;
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
	public Long getUserNoById(String userId) throws NoUserFoundException {
		// TODO Auto-generated method stub
		Long userNo = mapper.getNoById(userId);
		if(userNo==null) {
			throw new NoUserFoundException();
		}		
		return userNo;
	}
	
	@Override
	public UserVO getUserById(String userId) throws NoUserFoundException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserVO getUserbyEmail(String email) throws NoUserFoundException {
		// TODO Auto-generated method stub
		return mapper.selectByEmail(email);
	}

	@Override
	public UserVO getUserByNo(Long userNo) throws NoUserFoundException {
		// TODO Auto-generated method stub
		return mapper.selectByNo(userNo);
	}
	
	@Override
	public void registerNewUser(UserVO user) throws DuplicatedUserException {
		// TODO Auto-generated method stub
		if(!isLegitUserId(user.getUserId())) {
			throw new DuplicatedUserException("id");
		} else if (!isLegitUserEmail(user.getEmail())) {			
			throw new DuplicatedUserException("email");
		}
		try {
			mapper.insert(user);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			log.info("유저서비스임플#########sql integrity 문제로 가입실패");
		}
	}

	@Override
	public boolean isLegitUserId(String userId) {
		// TODO Auto-generated method stub
		return mapper.isLegitId(userId);
	}

	@Override
	public boolean isLegitUserEmail(String email) {
		// TODO Auto-generated method stub
		return mapper.isLegitEmail(email);
	}

	@Override
	public UserVO modifyUser(UserVO user) throws NoUserFoundException {
		// TODO Auto-generated method stub
		try {
			int i = mapper.update(user);
			if(i==0) {
				throw new NoUserFoundException();
			}
			return user;
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			log.info("유저서비스임플#########sql integrity 문제로 업뎃실패");
		}
		return null;
	}

	@Override
	public boolean deleteUser(UserVO user) throws NoUserFoundException {
		// TODO Auto-generated method stub
		try {
			int i = mapper.delete(user);
			if(i==0) {
				throw new NoUserFoundException();
			}
			return true;
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			log.info("유저서비스임플#########sql integrity 문제로 업뎃실패");
		}
		return false;
	}

	@Override
	public List<UserVO> getTotalList() {
		// TODO Auto-generated method stub
		return mapper.getTotalList();
	}

	@Override
	public List<UserVO> getMailingnList() {
		// TODO Auto-generated method stub
		return mapper.getMailingList();
	}

}
