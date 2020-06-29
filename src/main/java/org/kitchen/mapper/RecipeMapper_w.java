package org.kitchen.mapper;

import java.util.List;

import org.kitchen.domain.Criteria_w;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;

public interface RecipeMapper_w {
	public List<RecipeVO> getList();
	
	public List<RecipeVO> getListWithPaging(Criteria_w cri);
	
	public List<UserVO> getUserList(Criteria_w cri);
	
	public List<?> getAll(Criteria_w cri);
	
}
