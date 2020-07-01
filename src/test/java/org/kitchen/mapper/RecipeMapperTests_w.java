package org.kitchen.mapper;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kitchen.domain.Criteria_w;
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
public class RecipeMapperTests_w {
	
	@Setter(onMethod_ = @Autowired)
	private RecipeMapper_w mapper;
	
//	@Test
	public void testGetList()
	{
		mapper.getList().forEach(recipe->log.info(recipe));
	}
	
//	@Test
	public void testPaging() {
		Criteria_w cri = new Criteria_w();
		cri.setKeyword("7");
		
		List<RecipeVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(recipe->log.info(recipe));
	}
	
//	@Test
	public void testUser() {
		Criteria_w cri = new Criteria_w();
		cri.setKeyword("2");
		List<UserVO> list = mapper.getUserList(cri);
		list.forEach(user->log.info(user.getUserId()+"###"+user.getNickName()));
	}
	
	@Test
	public void testTag() {
		Criteria_w cri = new Criteria_w();
		cri.setKeyword("¹°");
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
			for(int i=0; i<rno.size(); i++) {
				String stringToConvert = String.valueOf(arr[i]);
				Long convertedLong = Long.parseLong(stringToConvert);
				recipeList.add(mapper.getRecipeByRno(convertedLong));
			}
		}
		recipeList.forEach(recipe1->log.info(recipe1));
	}
}
