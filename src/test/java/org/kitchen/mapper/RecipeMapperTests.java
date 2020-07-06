package org.kitchen.mapper;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kitchen.domain.Criteria;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RecipeMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private RecipeMapper mapper;
	
	@Test
	public void testGetList()
	{
		mapper.getList().forEach(recipe->log.info(recipe));
	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setKeyword("7");
		
		List<RecipeVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(recipe->log.info(recipe));
	}
	
	@Test
	public void testUser() {
		Criteria cri = new Criteria();
		cri.setKeyword("2");
		List<UserVO> list = mapper.getUserList(cri);
		list.forEach(user->log.info(user.getUserId()+"###"+user.getNickName()));
	}
	
	@Test
	public void testTag() {
		Criteria cri = new Criteria();
		cri.setKeyword("��");
		List<Long> tno = mapper.getTagNum(cri);		
		HashSet<Long> rno = new HashSet<Long>();
		List<RecipeVO> recipeList = new ArrayList<>();
		if(tno!=null)
		{
			for(int i=0; i<tno.size(); i++) {
				List<Long> tmp = mapper.getRnoByTagNum(tno.get(i));
				for(int j=0; j<tmp.size(); j++)
				{
					rno.add(tmp.get(j));
				}
			}
			Object[] arr = rno.toArray();
			List<Long> rnos = new ArrayList<>();
			for(int i=0; i<rno.size(); i++) {
				String stringToConvert = String.valueOf(arr[i]);
				Long convertedLong = Long.parseLong(stringToConvert);
				rnos.add(convertedLong);
			}
			recipeList.addAll(mapper.getRecipeByRno(rnos));
		}
		recipeList.forEach(recipe1->log.info(recipe1));
	}
	
	@Test
	public void testInsert()
	{
		RecipeVO recipe = new RecipeVO();
		
		recipe.setCookingTime(75L);
		recipe.setDifficulty("4");
		recipe.setUserNo(6L);
		recipe.setThumbnail("https://www.fabriziorocca.it/guide/wp-content/uploads/2018/03/thumb_14400082930User.png");
		recipe.setTitle("�����佺�� �丶�� �Ľ�Ÿ �����!");
		
		mapper.insert(recipe);
		
		log.info(recipe);
	}

	@Test
	public void testInsert2()
	{
		RecipeVO recipe = new RecipeVO();
		
		recipe.setCookingTime(45L);
		recipe.setDifficulty("3");
		recipe.setUserNo(1L);

		recipe.setThumbnail("https://www.fabriziorocca.it/guide/wp-content/uploads/2018/03/thumb_14400082930User.png");
		recipe.setTitle("��� Ǫ�� �����~! selectkey");

		recipe.setThumbnail("hii");
		recipe.setTitle("selectkey");
		recipe.setCategoryNo(11);
		recipe.setPortion("3");
		
		mapper.insert(recipe);
		
		log.info(recipe);
	}
	
	@Test
	public void testRead()
	{
		RecipeVO recipe = mapper.read(41L);
		
		log.info(recipe);
	}
	
	@Test
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
		RecipeVO original = mapper.read(41L);
		
		recipe.setRno(41L);
		recipe.setCookingTime(65L);
		recipe.setDifficulty("4");
		recipe.setRegDate(original.getRegDate());
		recipe.setUserNo(6L);
		recipe.setThumbnail("https://www.fabriziorocca.it/guide/wp-content/uploads/2018/03/thumb_14400082930User.png");
		recipe.setTitle("�����佺�� �丶�� �Ľ�Ÿ �����! ����");
		recipe.setCategoryNo(44);
		
		int count = mapper.update(recipe);
		log.info("UPDATE COUNT : " +  count);
	}
	
	
}
