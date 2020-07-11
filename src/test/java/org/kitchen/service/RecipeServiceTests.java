package org.kitchen.service;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kitchen.domain.ContentVO;
import org.kitchen.domain.RecipeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RecipeServiceTests {
	@Autowired
	private RecipeService service;

	@Test
	public void testGetList() {
		service.getList();
	}
	
	@Test
	public void testExist()
	{
		log.info(service);
		assertNotNull(service);
	}
	
//	@Test
	public void testRegister()
	{
		RecipeVO recipe = new RecipeVO();
		ContentVO content = new ContentVO();
		
		// 1. �Խù� ����
		recipe.setCookingTime("45");
		recipe.setDifficulty("3");
		recipe.setUserNo(6L);
		recipe.setThumbnail("������ ����");
		recipe.setTitle("������ �����~!");
		recipe.setCategoryNo(77);
		
		service.register(recipe);
		
		log.info("������ �Խù��� ��ȣ : " + recipe.getRno());
		
		Long number = recipe.getRno();
		
		
		// 2. �Խù� ���� ����
		// �ٵ� �������ε� ��������?
		// for�� ������ �ϳ�,,,
		content.setRno(number);
		content.setStepNo(1);
		content.setContent("���ڸ� �İ� ä���� ����ݴϴ� step1");
		content.setPhotoUrl("���� ä �� ����");
		
		service.registerCon(content);
		
		log.info("������ ����Ʈ�Խù��� ��ȣ : " + content.getStepNo());

	}
	
//	����Ʈ�� ���
//	@Test
	public void testRegisterCon()
	{
		ContentVO content = new ContentVO();
		
		content.setRno(47L);
		content.setStepNo(2);
		content.setContent("���ڸ� �İ� ä���� ����ݴϴ� step2");
		content.setPhotoUrl("���� ä �� ����");
		
		service.registerCon(content);
		
		log.info("������ ����Ʈ�Խù��� ��ȣ : " + content.getStepNo());
	}
	
//	@Test
	public void testGetList2()
	{
		service.getList().forEach(recipe -> log.info(recipe));
	}
	
//	@Test
	public void testGet()
	{
		log.info(service.get(47L));
	}
	
//	@Test
	public void testRemove()
	{
		log.info("REMOVE RESULT : " + service.remove(6L));
	}
	
//	@Test
	public void testUpdateRecipeContent()
	{
		RecipeVO recipe = service.get(48L);
		
		log.info("������ >> " + recipe);
		if (recipe == null) { return; }
		
		recipe.setTitle("����3 ����");
		recipe.setRegDate(recipe.getRegDate());
		recipe.setCookingTime("25");
		recipe.setDifficulty("4");
		recipe.setUserNo(5L);
		recipe.setThumbnail("������ URL");
		recipe.setCategoryNo(44);
		
		log.info("MODIFY RESULT : " + service.modify(recipe));
		
		List<ContentVO> contentList = service.getCon(recipe.getRno());
		
		int step = 1;
		ContentVO content = contentList.get(step-1);
		
		service.removeCon(content.getRno());
		
		content.setRno(content.getRno());
		content.setStepNo(content.getStepNo());
		content.setPhotoUrl("url1 ����");
		content.setContent("����1 ����");
		log.info(content);
		
		//log.info("MODIFYCON RESULT : " + service.ModifyCon(content));
		
	}
}
