package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.Criteria_w;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;




public interface RecipeService_w {
	public List<RecipeVO> getList(Criteria_w cri);
	public List<RecipeVO> moreRecipeList(Criteria_w cri);
	
	public List<UserVO> getUserList(Criteria_w cri);
	public List<UserVO> moreUserList(Criteria_w cri);
	
	public List<RecipeVO> getTagNum(Criteria_w cri);
	public List<RecipeVO> moreTagList(Criteria_w cri);
	
	public List<?> getAll(Criteria_w cri);
	
	public List<Long> getRnoByTagNum(Long tagNum);
	
	public int getTotalRecipe(Criteria_w cri);
	public int getTotalUser(Criteria_w cri);
	public long getTotalTag(Criteria_w cri);
}
