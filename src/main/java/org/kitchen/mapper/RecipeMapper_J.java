package org.kitchen.mapper;

import java.util.List;

import org.kitchen.domain.RecipeVO;

public interface RecipeMapper_J {
	public List<RecipeVO> getList();
	
	public void insert(RecipeVO recipe);
	
	public void insertSelectkey(RecipeVO recipe);
	
	public RecipeVO read(Long rno);
	
}
