package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.CategoryVO;
import org.kitchen.domain.ContentVO;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.SimpleRecipeDTO;
import org.kitchen.domain.TagVO;

public interface RecipeService {
	
	public Long register(RecipeVO recipe);

	public void registerCon(ContentVO content);

	public RecipeVO get(Long rno);

	public List<ContentVO> getCon(Long rno);

	public boolean modify(RecipeVO recipe);

	public boolean modifyCon(ContentVO content);

	public boolean remove(Long rno);

	public void removeCon(Long rno);

	public List<RecipeVO> getList();

	public List<Long> getRnoByTagNum(Long tagNum);

	public List<RecipeVO> getCategoryCode(Long categoryNo);
	
	public void register_w(RecipeVO recipe);

	public List<CategoryVO> getCategoryNamebyPrevCode(Long categoryNo);
	
	public boolean isMyRecipe(Long rno, Long userNo);
	
	public List<TagVO> getTagNameList();
	
	public RecipeVO getLatestRecipe();
	
	public int checkCode(Long categoryNo);
	
	public List<SimpleRecipeDTO> getSimpeRecipeByCategory(Long categoryNoLong);
}
