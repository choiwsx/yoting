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
public class RecipeMapperTests_J {
	
	@Setter(onMethod_ = @Autowired)
	private RecipeMapper_J mapper;
	
	@Test
	public void testGetList()
	{
		mapper.getList().forEach(recipe->log.info(recipe));
	}
}
