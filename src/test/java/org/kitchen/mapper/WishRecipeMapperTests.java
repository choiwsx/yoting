package org.kitchen.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class WishRecipeMapperTests {
	
	private static final Logger log = LoggerFactory.getLogger(WishRecipeMapperTests.class);
	
	@Autowired
	private WishRecipeMapper mapper;
	
	@Test
	public void testGetrno()
	{
		System.out.println(mapper.getRnoByUno((long)1));
	}

//	@Test
	public void testInsert(){

		mapper.insertRecipeRno((long)2,(long)5);
	}

//	@Test
	public void testDelete() {
		mapper.deleteRecipeRno((long)2, (long)5);
	}
	
//	@Test
	public void testUpdate() {
		mapper.updateRecipeRno((long)1, (long)4, (long)3);
	}
	
	
}
