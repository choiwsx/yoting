package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.ContentVO;
import org.kitchen.domain.RecipeVO;
import org.kitchen.mapper.ContentMapper;
import org.kitchen.mapper.RecipeMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecipeServiceImpl implements RecipeService {
	
	private static final Logger log = LoggerFactory.getLogger(RecipeServiceImpl.class);
	
	@Autowired
	private RecipeMapper recipeMapper;
	@Autowired
	private ContentMapper contentMapper;

	@Override
	public void register(RecipeVO recipe, ContentVO content) {
		Long rno = register(recipe);
		content.setRno(rno);
		registerCon(content);
	}

	@Override
	public void register(RecipeVO recipe, List<ContentVO> contents) {
		// TODO Auto-generated method stub
		Long rno = register(recipe);
		contents.forEach(a -> a.setRno(rno));
		contents.forEach(a -> registerCon(a));
	}

	@Override
	public void registerCon(ContentVO content) {
		contentMapper.insert(content);
	}

	@Override
	public boolean modify(RecipeVO recipe) {
		log.info("modify.........." + recipe);
		return recipeMapper.update(recipe) == 1;
	}

	@Override
	public boolean ModifyCon(ContentVO content) {
		log.info("modifyCon........" + content);
		return contentMapper.update(content) == 1;
	}

	@Override
	public boolean remove(Long rno) {
		log.info("remove.........." + rno);
		contentMapper.delete(rno);
		recipeMapper.deleteMaterial(rno);
		recipeMapper.deleteReview(rno);
		recipeMapper.deleteTag(rno);
		recipeMapper.deletewishRe(rno);
		return recipeMapper.deleteRecipe(rno) == 1;
	}

	@Override
	public void removeCon(Long rno) {
		log.info("removeCon......" + rno);
		contentMapper.delete(rno);
	}

	@Override
	public RecipeVO get(Long rno) {
		log.info("get.........." + rno);
		return recipeMapper.read(rno);
	}

	@Override
	public List<ContentVO> getCon(Long rno) {
		log.info("getCon......" + rno);
		return contentMapper.read(rno);
	}

	@Override
	public List<RecipeVO> getList() {
		log.info("getList..........");
		return recipeMapper.getList();
	}

	@Override
	public List<Long> getRnoByTagNum(Long tagNum) {
		// TODO Auto-generated method stub
		return recipeMapper.getRnoByTagNum(tagNum);
	}

	@Override
	public List<RecipeVO> getCategoryCode(Long categoryNo) {
		return recipeMapper.getCategoryCode(categoryNo);
	}

	@Override
	public Long register(RecipeVO recipe) {
		recipeMapper.insert(recipe);
		return recipe.getRno();
	}

}
