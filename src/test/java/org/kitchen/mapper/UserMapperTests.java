package org.kitchen.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kitchen.domain.UserVO;
import org.kitchen.enums.UserStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class UserMapperTests {
	
	private static final Logger log = LoggerFactory.getLogger(UserMapperTests.class);
	
	@Autowired
	private UserMapper mapper;
	
	
//	@Test
//	public void test() {
//
//	}
	
	
	
//	@Test
//	public void test() {
//		Boolean test = null;
//		mapper.test(test);
//		mapper.testcheck().forEach(a->log.info(a));
//	}
	
	//@Test
	public void testInsert() {
		UserVO user = new UserVO();
		user.setUserId("new16");
		user.setUserPwd("1234");
		user.setEmail("abc@sss.com");
		user.setEmailAuth(true);
		user.setNickName("우롱차");
		user.setProfilePhoto("http://www.google.com");
		user.setWebUrl("http://nav.com");
		user.setBio("나는18살이다");
		user.setEmailSub(true);
		user.setPrivacy(false);
		user.setStatus(UserStatus.PENDING);
		try {
			mapper.insert(user);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
		}
	}
	

	
	//@Test
	public void testSelectById() {
		UserVO user1 = mapper.selectById("user001");
		log.info("####1: "+user1);
		UserVO user2 = mapper.selectById("user04");
		log.info("#####4: "+user2);

//		UserVO user3 = mapper.selectById("newUserID");
//		log.info("12: "+user3);
	}
	
	//@Test
	public void testSelectByEmail() {
		log.info("#####: "+mapper.selectByEmail(mapper.selectByNo(4L).getEmail()));
	}
	
	//@Test
	public void testSelectByNo() {
		UserVO user1 = mapper.selectByNo(1L);
		log.info("1: "+user1);
		UserVO user2 = mapper.selectByNo(4L);
		log.info("4: "+user2);
		UserVO user3 = mapper.selectByNo(12L);
		log.info("12: "+user3);
	}
	
	//@Test
	public void testGetNoById() {
		Long a = mapper.getNoById("new4");
		Long b = mapper.getNoById("new6");
		log.info("######"+b);
	}
	
	//@Test
	public void testIsLegitId() {
		boolean f = mapper.idExists("new001");
		log.info("##############ISLEGITID"+f);
		
	}
	
	//@Test
	public void testIsLegitEmail() {
		boolean f = mapper.emailExists("abc@ssss.com");
		log.info("##############ISLEGITEMAIL"+f);
	}
	
	//@Test
	public void testIsPrivate() {
		boolean f1 = mapper.isPrivate("user01");
		log.info("##############1t"+f1);
		boolean f2 = mapper.isPrivate("user02");
		log.info("##############2t"+f2);
		boolean f3 = mapper.isPrivate("user03");
		log.info("##############3f"+f3);
		boolean f4 = mapper.isPrivate("user04");
		log.info("##############4f"+f4);
	}	

	//@Test
	public void testUpdate() {
		UserVO user = new UserVO();
		user.setUserId("new14");
		user.setUserPwd("1234");
		user.setEmail("abc@sss.com");
		user.setEmailAuth(true);
		user.setNickName("우롱차");
		user.setProfilePhoto("http://www.google.com");
		user.setWebUrl("http://nav.com");
		user.setBio("나는18살이다");
		user.setEmailSub(true);
		user.setPrivacy(false);
		user.setStatus(UserStatus.PENDING);
	}
	

	//@Test
	public void testUpdate2() {
		UserVO user = mapper.selectByNo(1L);
		log.info("#####");
		log.info("#####b"+user.getBio());		
		log.info("#####e"+user.getEmail());
		log.info("#####nn"+user.getNickName());
		log.info("#####pp"+user.getProfilePhoto());
		log.info("#####id"+user.getUserId()); 
		log.info("#####pwd"+user.getUserPwd());
		log.info("#####web"+user.getWebUrl());
		log.info("#####no"+user.getUserNo());
		log.info("#####stat"+user.getStatus());
		log.info("#####emailauth"+user.isEmailAuth());
		log.info("#####sub"+user.isEmailSub());
		log.info("#####priv"+user.isPrivacy());

		log.info("#####");
		user.setUserId("NEWNEW");
		log.info("########"+mapper.update(user));

	}
	
	//@Test
	public void testDelete() {
		log.info("#################################");
		UserVO user = mapper.selectByNo(17L);
		//log.info(user);
		//log.info(mapper.delete(user));
	}
	
	

	//@Test
	public void testDeletByNo() {
		log.info("delete");
		log.info("##########"+mapper.deleteByNo(38L));
//		log.info(mapper.deleteByNo(13L));
//		log.info(mapper.deleteByNo(14L));

	}
	
	//@Test
	public void testDeleteById() {
		log.info("###########3");
	}

	
	//@Test
	public void testGetMailingList() {
		mapper.getMailingList().forEach(user->log.info("#####"+user.isEmailSub()));
	}
	
	@Test
	public void testGetTotalList() {
		mapper.getTotalList().forEach(user->log.info(user.getUserId()));
	}
	
	//@Test
	public void testEnumHandler() {
		UserVO user = mapper.selectByNo(1L);
		log.info("@@@@"+user);
		
	}
	
	//@Test
	public void updateStatus() {
		List<UserVO> list = mapper.getTotalList();
		list.forEach(a->mapper.update(a));
		mapper.getTotalList();
	}

	
}
