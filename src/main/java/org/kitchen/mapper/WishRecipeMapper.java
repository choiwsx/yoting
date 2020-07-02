package org.kitchen.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface WishRecipeMapper {
	
	//---select-----
	public List<Long> getRnoByUno(Long uno);
	
	//--insert---
	public void insertRecipeRno(@Param("uno") Long uno, @Param("rno") Long rno);
	
	//--delete---
	public void deleteRecipeRno(@Param("uno") Long uno, @Param("rno") Long rno);
	
	//--update--
	public void updateRecipeRno(@Param("uno") Long uno, @Param("beforeRno") Long beforeRno, @Param("afterRno") Long afterRno);
	
}
