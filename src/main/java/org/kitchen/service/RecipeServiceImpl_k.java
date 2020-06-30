package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.RecipeVO;
import org.kitchen.mapper.RecipeMapper_k;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class RecipeServiceImpl_k implements RecipeService_k {
	
	@Setter(onMethod_ = @Autowired)
	private RecipeMapper_k mapper;

	@Override
	public List<RecipeVO> getList() {
		return mapper.getList();
	}

	@Override
	public List<RecipeVO> getCategoryCode(Long categoryNo) {
		return mapper.getCategoryCode(categoryNo);
	}

}
