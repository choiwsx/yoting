package org.kitchen.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kitchen.domain.UserVO;
import org.kitchen.enums.UserStatus;
import org.kitchen.exception_h.DuplicatedUserException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserServiceTests_h {
	
	@Setter(onMethod_= {@Autowired})
	private UserService_h service;
	
	@Test
	public void testGetUserNoById() {
		Long userNo = service.getUserNoById("user");
		
	}
	
	@Test
	public void testGetuserById() {
		
	}
	
	@Test
	public void testGetUserByEmail() {
		
	}
	
	@Test
	public void testGetUserByNo() {
		
	}
	
	//@Test
	public void testRegisterNewUser() {
		UserVO user = new UserVO();
		user.setUserId("new002");
		user.setUserPwd("1234");
		user.setEmail("abcde@sss.com");
		user.setEmailAuth(true);
		user.setNickName("우롱차");
		user.setProfilePhoto("http://www.google.com");
		user.setWebUrl("http://nav.com");
		user.setBio("나는18살이다");
		user.setEmailSub(true);
		user.setPrivacy(false);
		user.setStatus(UserStatus.PENDING);
		try {
			service.registerNewUser(user);
		} catch (DuplicatedUserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testIsLegitUserId() {
		boolean f = service.isLegitUserId("user");
		log.info("$$$LEGITID"+f);
	}
	
	@Test
	public void testIsLegitUserEmail() {
		boolean f = service.isLegitUserEmail("a@a.a");
		log.info("$$$LEGITEMAIL"+f);
	}
	
	@Test
	public void testModifyUser() {
		
	}
	
	@Test
	public void testDeleteUser() {
		
	}
	
	@Test
	public void testGetTotalList() {
		
	}
	
	@Test
	public void testGetMailingList() {
		
	}

}
