package org.kitchen.mapper;

import java.util.List;

import org.kitchen.domain.Criteria;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.TagVO;
import org.kitchen.domain.UserVO;

public interface RecipeMapper {

	public Long insert(RecipeVO recipe);

	public RecipeVO read(Long rno);

	public int update(RecipeVO recipe);

	public int deleteContent(Long rno);

	public int deleteMaterial(Long rno);

	public int deleteReview(Long rno);

	public int deleteTag(Long rno);

	public int deletewishRe(Long rno);

	public int deleteRecipe(Long rno);

	public int getTotalRecipeCount(Criteria cri);

	public int getTotalUserCount(Criteria cri);

	public List<RecipeVO> getList();

	public List<RecipeVO> getListWithPaging(Criteria cri);

	public List<RecipeVO> getRecipeListWithPaging(Criteria cri);

	public List<UserVO> getUserList(Criteria cri);

	public List<UserVO> getUserListWithPaging(Criteria cri);

	public List<Long> getTagNum(Criteria cri);

	public List<Long> getRnoByTagNum(Long tagNum);

	public List<RecipeVO> getRecipeByRno(List<Long> convertedLong);

	public List<RecipeVO> getRecipeByRnoWithPaging(Criteria cri);

	public List<RecipeVO> getTotalTagCount(Criteria cri);

	public List<RecipeVO> getCategoryCode(Long categoryNo);
	
	public List<RecipeVO> searchUserRecipeList(Criteria cri);
	
	public List<RecipeVO> getUserRecipeList(Long userNo);

	public Long getUserNoByRno(Long rno);

	public List<TagVO> getTagNameList();
}