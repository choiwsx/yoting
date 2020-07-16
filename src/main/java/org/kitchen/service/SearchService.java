package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.CategoryVO;
import org.kitchen.domain.Criteria;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.SimpleProfileDTO;
import org.kitchen.domain.SimpleRecipeDTO;
import org.kitchen.domain.UserVO;

public interface SearchService {
	
	public int getTotalUserCount(Criteria cri);

	public int getTotalTagCount(Criteria cri);
	
	public int getTotalRecipeCount(Criteria cri);

	public List<RecipeVO> moreTagList(Criteria cri);

	public List<RecipeVO> moreRecipeList(Criteria cri);

	public List<UserVO> moreUserList(Criteria cri);

	public List<RecipeVO> getTagNum(Criteria cri);

	public List<RecipeVO> getRecipeList(Criteria cri);

	public List<UserVO> getUserList(Criteria cri);
	
	public List<UserVO> getUserListById(Criteria cri);

	public List<RecipeVO> searchUserRecipeList(Criteria cri);
	
	public List<RecipeVO> getUserRecipeList(Long userNo);

	public List<CategoryVO> read();
	
	public List<SimpleProfileDTO> getHotUserList(int length);
	
	public List<SimpleRecipeDTO> getSimpleRecipeList(Criteria cri);
	public List<SimpleRecipeDTO> getSimpleRecipeMoreList(Criteria cri);


}
