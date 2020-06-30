package org.kitchen.service;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kitchen.domain.ContentVO;
import org.kitchen.domain.RecipeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RecipeServiceTests_J {
	
	@Setter(onMethod_= {@Autowired})
	private RecipeService_J service;
	
//	@Test
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
		
		// 1. 게시물 생성
		recipe.setCookingTime(45);
		recipe.setDifficulty("3");
		recipe.setUserNo(6L);
		recipe.setThumbnail("감자전 사진");
		recipe.setTitle("감자전 만들기~!");
		recipe.setCategoryNo(77);
		
		service.register(recipe);
		
		log.info("생성된 게시물의 번호 : " + recipe.getRno());
		
		Long number = recipe.getRno();
		
		
		// 2. 게시물 내용 생성
		// 근데 여러개인데 어케하지?
		// for문 돌려야 하남,,,
		content.setRno(number);
		content.setStepNo(1);
		content.setContent("감자를 씻고 채썰기로 썰어줍니다 step1");
		content.setPhotoUrl("감자 채 썬 사진");
		
		service.registerCon(content);
		
		log.info("생성된 컨텐트게시물의 번호 : " + content.getStepNo());

	}
	
//	컨텐트만 등록
//	@Test
	public void testRegisterCon()
	{
		ContentVO content = new ContentVO();
		
		content.setRno(47L);
		content.setStepNo(2);
		content.setContent("감자를 씻고 채썰기로 썰어줍니다 step2");
		content.setPhotoUrl("감자 채 썬 사진");
		
		service.registerCon(content);
		
		log.info("생성된 컨텐트게시물의 번호 : " + content.getStepNo());
	}
	
//	@Test
	public void testGetList()
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
		
		log.info("레시피 >> " + recipe);
		if (recipe == null) { return; }
		
		recipe.setTitle("제목3 수정");
		recipe.setRegdate(recipe.getRegdate());
		recipe.setCookingTime(25);
		recipe.setDifficulty("4");
		recipe.setUserNo(5L);
		recipe.setThumbnail("수정한 URL");
		recipe.setCategoryNo(44);
		
		log.info("MODIFY RESULT : " + service.modify(recipe));
		
		List<ContentVO> contentList = service.getCon(recipe.getRno());
		
		int step = 1;
		ContentVO content = contentList.get(step-1);
		
		service.removeCon(content.getRno());
		
		content.setRno(content.getRno());
		content.setStepNo(content.getStepNo());
		content.setPhotoUrl("url1 수정");
		content.setContent("내용1 수정");
		log.info(content);
		
		log.info("MODIFYCON RESULT : " + service.ModifyCon(content));
		
	}
}
