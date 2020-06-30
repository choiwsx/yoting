package org.kitchen.mapper;

import java.util.List;

import org.kitchen.domain.RecipeVO;

public interface RecipeMapper_J {
	public List<RecipeVO> getList();
	
	public void insert(RecipeVO recipe);
	
	public void insertSelectkey(RecipeVO recipe);
	
	public RecipeVO read(Long rno);
	
	// Recipe게시물 삭제 시 참조키되어있는 테이블
	// r_num 찾아서 지워준 후
	// recipe게시물 삭제
	
	public int deleteContent(Long rno);
	
	public int deleteMaterial(Long rno);
	
	public int deleteReview(Long rno);
	
	public int deleteTag(Long rno);
	
	public int deletewishRe(Long rno);
	
	public int deleteRecipe(Long rno);
	
	public int update(RecipeVO recipe);
	
}
