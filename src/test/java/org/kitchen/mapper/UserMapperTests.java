package org.kitchen.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kitchen.domain.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserMapperTests {
	
	@Setter(onMethod_=@Autowired)
	private UserMapper mapper;
	
	@Test
	public void testRegister() {
		UserVO user = new UserVO();
		user.setUserId("newUserID");
		user.setUserPwd("1234");
		user.setEmail("abc@sss.com");
		user.setEmailAuth("y");
		user.setNickName("우롱차");
		user.setProfilePhoto("http://www.google.com");
		user.setWebUrl("http://nav.com");
		user.setBio("나는18살이다");
		user.setEmailSub("y");
		user.setPrivacy(true);
		user.setStatus("a");
		
		int userNo=mapper.register(user);
		log.info("TestRegister"+user+" userNo="+userNo);
	}
	
	@Test
	public void testGetByUser() {
		
	}
	
	@Test
	public void testGetByUserId() {
		
	}
	
	@Test
	public void testGetByUserNo() {
		
	}
	
	@Test
	public void testModify() {
		
	}
	
	@Test
	public void testRemove() {
		
	}
	
	@Test
	public void testGetList() {
		
	}
	
	@Test
	public void testGetTotalList() {
		mapper.getTotalList().forEach(user->log.info(user));
	}

	
}
