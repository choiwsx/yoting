package org.kitchen.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kitchen.domain.UserVO;
import org.kitchen.enums.UserStatus;
import org.kitchen.exception.DuplicatedUserException;
import org.kitchen.exception.NoUserFoundException;
import org.kitchen.exception.UserMapperFailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserServiceTests {
	
	@Autowired
	private UserService service;
	
	//@Test
	public void testGetUserNoById() {
		Long userNo = service.getUserNoById("user01");
		log.info("@@@"+service.getUserById("user01").getStatus());
		
	}
	
	//@Test
	public void testGetuserById() {
		UserVO user = service.getUserById("user01");
	}
	
	//@Test
	public void testGetUserByEmail() {
		UserVO user = service.getUserByEmail("a@a.a");
	}
	
	//@Test
	public void testGetUserByNo() {
		UserVO user = service.getUserByNo(3L);
		log.info(user);
	}
	
	//@Test
	public void testRegisterNewUser() {
		UserVO user = new UserVO();
		user.setUserId("new1");
		user.setUserPwd("1234");
		user.setEmail("abcde@sss.com");
		user.setEmailAuth(true);
		user.setNickName("우롱차");
		user.setProfilePhoto("http://www.google.com");
		user.setWebUrl("http://nav.com");
		user.setBio("나는18살이다");
		user.setEmailSub(true);
		user.setPrivacy(false);
		user.setStatus(UserStatus.DELETED);
		try {
			service.registerNewUser(user);
		} catch (DuplicatedUserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UserMapperFailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//@Test
	public void testIsLegitUserId() {
		boolean f1 = service.isLegitUserId("user");
		log.info("$$$LEGITID"+f1);
		boolean f2 = service.isLegitUserId("user01");
		log.info("$$$LEGITID"+f2);
	}
	
	//@Test
	public void testIsLegitUserEmail() {
		boolean f1 = service.isLegitUserEmail("a@a.a");
		log.info("$$$LEGITEMAIL"+f1);
		boolean f2 = service.isLegitUserEmail("a@a.aa");
		log.info("$$$LEGITEMAIL"+f2);
	}
	
	//@Test
	public void testModifyUser() {
		try {
			UserVO user = service.getUserById("user01");
			user.setBio("zzzz");
			if(service.modifyUser(user)) {
				log.info("########유저#업뎃완료");
			}			
		} catch (UserMapperFailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//@Test
	public void testDeleteUser() {
		try {
			UserVO user = service.getUserById("user01");
			user.setBio("zzzz");
			if(service.deleteUser(user)) {
				log.info("########유저#삭제완료");
			}			
		} catch (UserMapperFailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//@Test
	public void testGetTotalList() {
		service.getTotalList().forEach(a->log.info(a));
	}
	
	//@Test
	public void testGetMailingList() {
		service.getMailingnList().forEach(a->log.info("mail##########"+a.isEmailSub()));
	}
	
	@Test
	public void set() {
		service.activateUser(1L);
	}

}
