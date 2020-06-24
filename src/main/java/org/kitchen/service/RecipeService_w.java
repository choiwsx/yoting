package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.RecipeVO;
import org.springframework.stereotype.Service;



@Service

public interface RecipeService_w {
	public List<RecipeVO> getList();
}
