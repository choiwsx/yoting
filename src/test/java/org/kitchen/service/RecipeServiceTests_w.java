package org.kitchen.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kitchen.domain.Criteria_w;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RecipeServiceTests_w {
	@Setter(onMethod_= {@Autowired})
	private RecipeService_w service;
	
	@Test
	public void testGetList() {
		service.getList(new Criteria_w(2,5)).forEach(recipe->log.info(recipe));
	}
}
