package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.RecipeVO;


public interface RecipeService_k {
	public List<RecipeVO> getList();

	
	public List<RecipeVO> getCategoryCode(Long categoryNo);

	
}
