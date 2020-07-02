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
public class WishRecipeMapperTests {
	
	@Setter(onMethod_ = @Autowired)
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
