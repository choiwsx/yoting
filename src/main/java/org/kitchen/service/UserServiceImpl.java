package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.UserVO;
import org.kitchen.exception_h.DuplicatedUserException;
import org.kitchen.exception_h.NoUserFoundException;
import org.kitchen.exception_h.UserMapperFailException;
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
		UserVO user = mapper.selectById(userId);
		if(user==null) {
			throw new NoUserFoundException();
		}
		return user;
	}

	@Override
	public UserVO getUserByEmail(String email) throws NoUserFoundException {
		// TODO Auto-generated method stub
		UserVO user = mapper.selectByEmail(email);
		if(user==null) {
			throw new NoUserFoundException();
		}
		return user;
	}

	@Override
	public UserVO getUserByNo(Long userNo) throws NoUserFoundException {
		// TODO Auto-generated method stub
		UserVO user = mapper.selectByNo(userNo);
		if(user==null) {
			throw new NoUserFoundException();
		}
		return user;
	}
	
	@Override
	public void registerNewUser(UserVO user) throws DuplicatedUserException, UserMapperFailException {
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
			throw new UserMapperFailException();
		}
	}
	
	@Override
	public boolean isLegitNewUser(UserVO user) throws DuplicatedUserException {
		// TODO Auto-generated method stub
		return isLegitUserId(user.getUserId()) && isLegitUserEmail(user.getEmail());
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
	public boolean modifyUser(UserVO user) throws NoUserFoundException, UserMapperFailException {
		// TODO Auto-generated method stub
		try {
			int i = mapper.update(user);
			if(i==0) {
				throw new NoUserFoundException();
			}
			return true;
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			throw new UserMapperFailException();
		}
	}

	@Override
	public boolean deleteUser(UserVO user) throws NoUserFoundException, UserMapperFailException {
		// TODO Auto-generated method stub
		try {
			int i = mapper.delete(user);
			if(i==0) {
				throw new NoUserFoundException();
			}
			return true;
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			throw new UserMapperFailException();
		}
	}

	@Override
	public List<UserVO> getTotalList() throws NoUserFoundException {
		// TODO Auto-generated method stub
		List<UserVO> totalList = mapper.getTotalList();
		if(totalList.size()==0) {
			throw new NoUserFoundException();
		}
		return totalList;
	}

	@Override
	public List<UserVO> getMailingnList() throws NoUserFoundException {
		// TODO Auto-generated method stub
		List<UserVO> mailingList = mapper.getMailingList();
		if(mailingList.size()==0) {
			throw new NoUserFoundException();
		}
		return mailingList;
	}


}
