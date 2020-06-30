package org.kitchen.service;

import java.util.List;

import org.kitchen.domain.ContentVO;
import org.kitchen.domain.RecipeVO;
import org.kitchen.mapper.ContentMapper;
import org.kitchen.mapper.RecipeMapper_J;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class RecipeServiceImpl_J implements RecipeService_J {

	private RecipeMapper_J mapper;
	private ContentMapper mapperCon;

	@Override
	public void register(RecipeVO recipe) {
		mapper.insert(recipe);
	}

	@Override
	public void registerCon(ContentVO content) {
		mapperCon.insert(content);
	}

	@Override
	public boolean modify(RecipeVO recipe) {
		log.info("modify.........." + recipe);
		return mapper.update(recipe) == 1;
	}

	@Override
	public boolean ModifyCon(ContentVO content) {
		
		log.info("modifyCon........" + content);
		return mapperCon.update(content) == 1;
	}

	@Override
	public boolean remove(Long rno) {
		log.info("remove.........." + rno);
		mapperCon.delete(rno);
		mapper.deleteMaterial(rno);
		mapper.deleteReview(rno);
		mapper.deleteTag(rno);
		mapper.deletewishRe(rno);

		return mapper.deleteRecipe(rno) == 1;
	}

	@Override
	public void removeCon(Long rno) {
		
		log.info("removeCon......" + rno);
		mapperCon.delete(rno);
	}

	@Override
	public RecipeVO get(Long rno) {
		
		log.info("get.........." + rno);
		return mapper.read(rno);
	}

	@Override
	public List<ContentVO> getCon(Long rno) {
		
		log.info("getCon......" + rno);
		return mapperCon.read(rno);
	}

	@Override
	public List<RecipeVO> getList() {

		log.info("getList..........");
		return mapper.getList();
	}
}
