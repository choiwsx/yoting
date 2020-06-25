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
	
//	@Test
//	public void test() {
//		Boolean test = null;
//		mapper.test(test);
//		mapper.testcheck().forEach(a->log.info(a));
//	}
	
	@Test
	public void testInsert() {
		UserVO user = new UserVO();
		user.setUserId("new4");
		user.setUserPwd("1234");
		user.setEmail("abc@sss.com");
		user.setEmailAuth(true);
		user.setNickName("우롱차");
		user.setProfilePhoto("http://www.google.com");
		user.setWebUrl("http://nav.com");
		user.setBio("나는18살이다");
		user.setEmailSub(true);
		user.setPrivacy(false);
		user.setStatus('1');
		
		int userNo=mapper.insert(user);
		log.info("TestRegister"+user+" userNo="+userNo);
	}
//	
//	@Test
//	public void testGetByUser() {
//
//	}
//	
//	@Test
//	public void testSelectById() {
//		UserVO user1 = mapper.selectById("user01");
//		log.info("1: "+user1);
//		UserVO user2 = mapper.selectById("user04");
//		log.info("4: "+user2);
//		UserVO user3 = mapper.selectById("newUserID");
//		log.info("12: "+user3);
//	}
//	
//	@Test
//	public void testSelectByNo() {
//		UserVO user1 = mapper.selectByNo(1L);
//		log.info("1: "+user1);
//		UserVO user2 = mapper.selectByNo(4L);
//		log.info("4: "+user2);
//		UserVO user3 = mapper.selectByNo(12L);
//		log.info("12: "+user3);
//	}
//	
//	@Test
//	public void testUpdate() {
//		UserVO user = mapper.selectByNo(17L);
//		user.setUserId("newu");
//		log.info(mapper.update(user));
//		mapper.getTotalList().forEach(u->log.info(u));
//	}
//	
//	@Test
//	public void testDelete() {
//		log.info("#################################");
//		UserVO user = mapper.selectByNo(22L);
//		log.info(mapper.delete(user));
//	}
	
	
//	@Test
//	public void testDeletByNo() {
//		log.info("delete");
//		log.info(mapper.deleteByNo(20L));
////		log.info(mapper.deleteByNo(13L));
////		log.info(mapper.deleteByNo(14L));
//
//	}
	
//	@Test
//	public void testDeleteById() {
//		log.info("delete");
//		log.info(mapper.deleteById("newu"));
//	}

//	
//	@Test
//	public void testGetList() {
//		
//	}
//	
//	@Test
//	public void testGetTotalList() {
//		mapper.getTotalList().forEach(user->log.info(user));
//	}

	
}
