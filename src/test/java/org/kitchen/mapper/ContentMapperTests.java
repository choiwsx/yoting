package org.kitchen.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kitchen.domain.ContentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ContentMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private ContentMapper mapper;
	
//	@Test
	public void testGetList() {
		mapper.getList().forEach(content -> log.info(content));
	}
	
	@Test
	public void testInsert() {
		
		ContentVO content = new ContentVO();
		
		content.setStepNo(1);
	}
}
