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
public class CategoryMapperTests {
	
	@Setter(onMethod_ = @Autowired)
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
