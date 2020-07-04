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
public class CategoryMapperTests {
	
	private static final Logger log = LoggerFactory.getLogger(CategoryMapperTests.class);
	
	@Autowired
	private CategoryMapper mapper;
	
	@Test
	public void testGetList() {
		System.out.println(mapper.getCategoryNameByCode(11));
	}
	
//	@Test
	public void testGetMC() {
		System.out.println("@@@@"+mapper.getMCByLC(11));
	}
	
//	@Test
	public void testGetLC() {
		String LargeCategory = mapper.getCategoryNameByCode(mapper.getLCbyMC(44));
		System.out.println(LargeCategory);
	}
//	@Test
	public void testInsert() {
		mapper.insertCategory(100, "ss", 11);
	}
//	@Test
	public void testDelete() {
		mapper.deleteCategory(100);
	}
	
//	@Test
	public void testUpdate() {
		mapper.updateCategory(100, "ssd", 22);
	}
	
}
