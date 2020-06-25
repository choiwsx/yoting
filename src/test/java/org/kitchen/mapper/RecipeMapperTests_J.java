package org.kitchen.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kitchen.domain.RecipeVO;
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
	
//	@Test
	public void testInsert()
	{
		RecipeVO recipe = new RecipeVO();
		
		recipe.setCookingTime(75);
		recipe.setDifficulty("4");
		recipe.setUserNo(6L);
		recipe.setThumbnail("https://www.fabriziorocca.it/guide/wp-content/uploads/2018/03/thumb_14400082930User.png");
		recipe.setTitle("�����佺�� �丶�� �Ľ�Ÿ �����!");
		recipe.setCategoryNo(44);
		
		mapper.insert(recipe);
		
		log.info(recipe);
	}
	
	// PK ������+Ÿ���̴޶� ���� ��������.. �����O,,,
//	@Test
	public void testInsertSelectKey()
	{
		RecipeVO recipe = new RecipeVO();
		
		recipe.setCookingTime(45);
		recipe.setDifficulty("3");
		recipe.setUserNo(6L);
		recipe.setThumbnail("https://www.fabriziorocca.it/guide/wp-content/uploads/2018/03/thumb_14400082930User.png");
		recipe.setTitle("��� Ǫ�� �����~! selectkey");
		recipe.setCategoryNo(77);
		
		mapper.insertSelectkey(recipe);
		
		log.info(recipe);
	}
	
//	@Test
	public void testRead()
	{
		RecipeVO recipe = mapper.read(6L);
		
		log.info(recipe);
	}
	
//	@Test
	public void testDeleteRecipe()
	{
		log.info("DELETE CONTENT COUNT : " + mapper.deleteContent(2L));
		log.info("DELETE MATERIAL COUNT : " + mapper.deleteMaterial(2L));
		log.info("DELETE REVIEW COUNT : " + mapper.deleteReview(2L));
		log.info("DELETE REVIEW COUNT : " + mapper.deleteTag(2L));
		log.info("DELETE REVIEW COUNT : " + mapper.deletewishRe(2L));
		log.info("DELETE RECIPE COUNT : " + mapper.deleteRecipe(2L));
	}
	
	@Test
	public void testUpdate()
	{
		RecipeVO recipe = new RecipeVO();
		
		recipe.setRno(41L);
		recipe.setCookingTime(65);
		recipe.setDifficulty("4");
//		���� ��� �ؾ����� ��¥ 2020-06-23�� �ְ� ������ �׷��� 8�ڸ����� ��
//		recipe.setRegdate(2020-06-23);
		recipe.setUserNo(6L);
		recipe.setThumbnail("https://www.fabriziorocca.it/guide/wp-content/uploads/2018/03/thumb_14400082930User.png");
		recipe.setTitle("�����佺�� �丶�� �Ľ�Ÿ �����!");
		recipe.setCategoryNo(44);
		
		int count = mapper.update(recipe);
		log.info("UPDATE COUNT : " +  count);
	}
}
