package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.Criteria_w;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;




public interface RecipeService_w {
	public List<RecipeVO> getList(Criteria_w cri);
	
	public List<UserVO> getUserList(Criteria_w cri);
	
}
