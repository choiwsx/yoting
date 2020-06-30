package org.kitchen.mapper;

import java.util.List;

import org.kitchen.domain.RecipeVO;

public interface RecipeMapper_J {
	public List<RecipeVO> getList();
	
	public void insert(RecipeVO recipe);
	
	public void insertSelectkey(RecipeVO recipe);
	
	public RecipeVO read(Long rno);
	
	// Recipe�Խù� ���� �� ����Ű�Ǿ��ִ� ���̺�
	// r_num ã�Ƽ� ������ ��
	// recipe�Խù� ����
	
	public int deleteContent(Long rno);
	
	public int deleteMaterial(Long rno);
	
	public int deleteReview(Long rno);
	
	public int deleteTag(Long rno);
	
	public int deletewishRe(Long rno);
	
	public int deleteRecipe(Long rno);
	
	public int update(RecipeVO recipe);
	
}
