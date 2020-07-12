package org.kitchen.service;

import java.util.List;

import javax.annotation.Resource;

import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;
import org.kitchen.enums.UserStatus;
import org.kitchen.exception.DuplicatedUserException;
import org.kitchen.exception.UserMapperFailException;
import org.kitchen.mapper.RecipeMapper;
import org.kitchen.mapper.UserMapper;
import org.kitchen.validation.VerificationEmailSender;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private RecipeMapper recipeMapper;

	@Resource
	private VerificationEmailSender verificationEmailSender;

	@Override
	public Long getUserNoById(String userId) {
		// TODO Auto-generated method stub
		return userMapper.getNoById(userId);
	}

	@Override
	public UserVO getUserById(String userId) {
		// TODO Auto-generated method stub
		return userMapper.selectById(userId);
	}

	@Override
	public UserVO getUserByEmail(String email) {
		// TODO Auto-generated method stub
		return userMapper.selectByEmail(email);
	}

	@Override
	public UserVO getUserByNo(Long userNo) {
		// TODO Auto-generated method stub
		return userMapper.selectByNo(userNo);
	}

	@Override
	public boolean isLegitNewUser(UserVO user) {
		// TODO Auto-generated method stub
		if(user==null) return false;
		return isLegitUserId(user.getUserId()) && isLegitUserEmail(user.getEmail());
	}

	@Override
	public boolean isLegitUserId(String userId) {
		// TODO Auto-generated method stub
		if(userMapper.idExists(userId)) {
			return false;
		}
		return true;
	}

	@Override
	public boolean isLegitUserEmail(String email) {
		// TODO Auto-generated method stub
		if(userMapper.emailExists(email)) {
			return false;
		}
		return true;
	}

	@Override
	public void registerNewUser(UserVO user) throws DuplicatedUserException, UserMapperFailException {
		// TODO Auto-generated method stub
		if(user!=null) {
			if (!isLegitUserId(user.getUserId())) {
				throw new DuplicatedUserException("id");
			} else if (!isLegitUserEmail(user.getEmail())) {
				throw new DuplicatedUserException("email");
			}		
			try {
				userMapper.insert(user);
				sendVerificationEmail(user);
			} catch (DataIntegrityViolationException e) {
				e.printStackTrace();
				throw new UserMapperFailException();
			}
		}
	}

	@Override
	public void sendVerificationEmail(UserVO user) {
		if(user!=null) {																
			String key = VerificationEmailSender.generateString();
			log.info("key:@@@@@@" + key);
			
			if(userMapper.getVeriKey(user.getUserNo())==null) {
			userMapper.insertVeriKey(user.getUserNo(), key);
			} else {
				userMapper.updateVeriKey(user.getUserNo(), key);
			}
			verificationEmailSender.send(user, key);
		}
	}

	@Override
	public boolean verifyEmail(Long userNo, String paramKey) {
		if (userNo == null || paramKey == null) {
			return false;
		}
		String solidKey = userMapper.getVeriKey(userNo);
		if (solidKey.equals(paramKey))
			return true;
		return false;
	}

	@Override
	public boolean activateUser(Long userNo) {
		UserVO user = userMapper.selectByNo(userNo);
		if (user == null) {
			return false;
		}
		user.setStatus(UserStatus.ACTIVE);
		return userMapper.update(user) == 1;
	}

	@Override
	public boolean modifyUser(UserVO user) throws UserMapperFailException {
		// TODO Auto-generated method stub
		try {
			int i = userMapper.update(user);
			if (i == 0) {
				return false;
			}
			return true;
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			throw new UserMapperFailException();
		}
	}

	@Override
	public boolean deleteUser(UserVO user) throws UserMapperFailException {
		// TODO Auto-generated method stub
		try {
			if (userMapper.delete(user) == 1) {
				return true;
			}
			return false;
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			throw new UserMapperFailException();
		}
	}

	@Override
	public boolean deleteUserByNo(Long userNo) throws UserMapperFailException {
		// TODO Auto-generated method stub
		try {
			if (userMapper.deleteByNo(userNo) == 1) {
				return true;
			}
			return false;
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			throw new UserMapperFailException();
		}
	}

	@Override
	public List<UserVO> getTotalList() {
		// TODO Auto-generated method stub
		return userMapper.getTotalList();
	}

	@Override
	public List<UserVO> getMailingnList() {
		// TODO Auto-generated method stub
		return userMapper.getMailingList();
	}

	@Override
	public List<UserVO> getProfile(String userId) {
		return userMapper.getProfile(userId);
	}

	@Override
	public List<RecipeVO> getUserRecipeList(Long userNo) {
		// TODO Auto-generated method stub
		return recipeMapper.getUserRecipeList(userNo);
	}
	
	@Override
	public List<UserVO> getIdAutocomplete(String userId){
		return userMapper.getIdAutocomplete(userId);
	}

	@Override
	public UserVO tempLogin(UserVO user) {
		// TODO Auto-generated method stub
		if(user==null) {
			return null;
		}
		UserVO userCompare = userMapper.selectById(user.getUserId());
		if(userCompare==null) return null;
		if(user.getUserPwd().equals(userCompare.getUserPwd())) {
			return userCompare;
		}
		return null;
	}

	@Override
	public boolean follow(Long followeeNo, Long followerNo) {
		// TODO Auto-generated method stub
		if(userMapper.userExists(followerNo)&&userMapper.userExists(followeeNo)) {
			userMapper.follow(followeeNo, followerNo);
			if(userMapper.countFollower(followeeNo, followerNo)==1) return true;
		}
		return false;
	}

	@Override
	public boolean unfollow(Long followeeNo, Long followerNo) {
		// TODO Auto-generated method stub
		if(userMapper.userExists(followerNo)&&userMapper.userExists(followeeNo)) {
			return userMapper.unfollow(followeeNo, followerNo)==1;
		}
		return false;
	}

	@Override
	public int countFollower(Long followeeNo) {
		// TODO Auto-generated method stub
		return userMapper.countFollower(followeeNo, null);
	}

	@Override
	public int countFollower(Long followeeNo, Long followerNo) {
		// TODO Auto-generated method stub
		return userMapper.countFollower(followeeNo, followerNo);
	}

	@Override
	public int countFollowing(Long followerNo) {
		// TODO Auto-generated method stub
		return userMapper.countFollowing(followerNo);
	}

	@Override
	public boolean isValidUser(Long userNo) {
		// TODO Auto-generated method stub
		if(userNo==null) return false;
		return userMapper.userExists(userNo);
	}

	
}
