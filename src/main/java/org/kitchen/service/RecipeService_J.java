package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.ContentVO;
import org.kitchen.domain.RecipeVO;
import org.springframework.stereotype.Service;

public interface RecipeService_J {
	
	public void register(RecipeVO recipe);
	
	public void registerCon(ContentVO content);
	
	public RecipeVO get(Long rno);
	
	public List<ContentVO> getCon(Long rno);
	
	public boolean modify(RecipeVO recipe);
	
	public boolean ModifyCon(ContentVO content);
	
	public boolean remove(Long rno);
	
	public void removeCon(Long rno);
	
	public List<RecipeVO> getList();
		
}
