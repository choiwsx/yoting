package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.CategoryVO;
import org.kitchen.domain.ContentVO;
import org.kitchen.domain.RecipeVO;
import org.kitchen.mapper.CategoryMapper;
import org.kitchen.mapper.ContentMapper;
import org.kitchen.mapper.RecipeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class RecipeServiceImpl implements RecipeService {
	
	@Autowired
	private RecipeMapper recipeMapper;
	@Autowired
	private ContentMapper contentMapper;
	@Autowired
	private CategoryMapper categoryMapper;

	@Override
	public void register(RecipeVO recipe, ContentVO content) {
		Long rno = register(recipe);
		content.setRno(rno);
		registerCon(content);
	}


	@Override
	public void register(RecipeVO recipe, List<ContentVO> contents) {
		// TODO Auto-generated method stub
		
		//contents.forEach(a -> a.setRno(rno));
		//contents.forEach(a -> registerCon(a));
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
	public List<CategoryVO> getCategoryNamebyPrevCode(Long categoryNo) {
		return categoryMapper.getCategoryNamebyPrevCode(categoryNo);
	}

	@Override
	public Long register(RecipeVO recipe) {
		recipeMapper.insert(recipe);
		log.info("#####################################################");
		for(int i = 0; i<10; i++) {
			if(recipe.getContentList().get(i).getContent()=="") {
				log.info("^^"+i);
				recipe.setContentList(recipe.getContentList().subList(0, i));
				break;
			}
		}
		recipe.getContentList().forEach(a -> log.info("#list#"+a));
		recipe.getContentList().forEach(a -> a.setRno(recipe.getRno()));
		recipe.getContentList().forEach(a ->registerCon(a));
		return recipe.getRno();
	}
	

	@Transactional
	@Override
	public void register_w(RecipeVO recipe)
	{
		Long rno = register(recipe);
		log.info("@@@rno"+rno);
		
		for(int i=0; i<recipe.getContentList().size(); i++)
		{
			recipe.getContentList().get(i).setRno(rno);
			contentMapper.insert(recipe.getContentList().get(i));
		}
	}


	@Override
	public Long isMyRecipe(Long rno) {
		// TODO Auto-generated method stub
		return recipeMapper.getUserNoByRno(rno);
	}


}
