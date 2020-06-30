package org.kitchen.mapper;

import java.util.List;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;

public interface RecipeMapper_k {
	public List<RecipeVO> getList();
	
	public List<RecipeVO> getCategoryCode(Long categoryNo);
}
