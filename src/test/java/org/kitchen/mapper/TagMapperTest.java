package org.kitchen.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class TagMapperTest {
	
	@Setter(onMethod_=@Autowired)
	private TagMapper mapper;
	
	
	//@Test
	public void testInsert() {
		mapper.insert("호박고구마");
	}
	
	//@Test
	public void testSelectByNo() {
		log.info("result: " + mapper.selectByNo(30L));
		
	}
	//@Test
	public void testSelectByName() {
		log.info("result: " + mapper.selectByName("김치"));
		
	}
	//@Test
	public void testDeleteByNo() {
		log.info("delete tag: " + mapper.deleteByNo(30L));
		
	}
	//@Test
	public void testDeleteByName() {
		log.info("delete tag: " + mapper.deleteByName("김치"));
		
	}
	
	
}
