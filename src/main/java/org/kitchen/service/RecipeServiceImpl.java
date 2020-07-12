package org.kitchen.service;

import java.util.ArrayList;
import java.util.List;

import org.kitchen.domain.CategoryVO;
import org.kitchen.domain.ContentVO;
import org.kitchen.domain.ModelDTOFactory;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.SimpleRecipeDTO;
import org.kitchen.domain.TagVO;
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
   public Long register(RecipeVO recipe) {
	  if(recipe==null) return null; 
      recipeMapper.insert(recipe);
      recipe.getContentList().forEach(a -> a.setRno(recipe.getRno()));
      recipe.getContentList().forEach(a ->registerCon(a));
      return recipe.getRno();
   }

   @Override
   public void registerCon(ContentVO content) {
      contentMapper.insert(content);
   }

   @Override
   public boolean modify(RecipeVO recipe) {
      log.info("modify.........." + recipe);
      boolean result = recipeMapper.update(recipe) == 1;
      recipe.getContentList().forEach(a -> modifyCon(a));
      return result;
   }

   @Override
   public boolean modifyCon(ContentVO content) {
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
      RecipeVO recipe = recipeMapper.read(rno);
      if(recipe!=null) {
         recipe.setContentList(getCon(rno));
      }
      List<ContentVO> contents = contentMapper.read(rno);
      if(contents==null)
      {
         contents = new ArrayList<ContentVO>();
      }
      else if(contents.size()<10)
      {
         int j = contents.size();
         for(int i=contents.size(); i<10; i++)
         {
            ContentVO content = new ContentVO();
//            content.setRno(rno);
            log.info(rno);
            content.setStepNo(j);
            contents.add(content);
            j++;
         }
         log.info(contents);
         recipe.setContentList(contents);
      }
      List<ContentVO> contents = contentMapper.read(rno);
      if(contents==null)
      {
    	  contents = new ArrayList<ContentVO>();
      }
      else if(contents.size()<10)
      {
    	  int j = contents.size();
    	  for(int i=contents.size(); i<10; i++)
    	  {
    		  ContentVO content = new ContentVO();
//    		  content.setRno(rno);
    		  log.info(rno);
    		  content.setStepNo(j);
    		  contents.add(content);
    		  j++;
    	  }
    	  log.info(contents);
    	  recipe.setContentList(contents);
      }
      return recipe;
   }

   @Override
   public List<ContentVO> getCon(Long rno) {
      log.info("getCon......" + rno);
      return contentMapper.read(rno);
   }

   @Override
   public List<RecipeVO> getList() {
      log.info("getList..........");
      List<RecipeVO> list = recipeMapper.getList();
      list.forEach(a->a.setContentList(getCon(a.getRno())));
      return list;
   }

   @Override
   public List<Long> getRnoByTagNum(Long tagNum) {
      // TODO Auto-generated method stub
      return recipeMapper.getRnoByTagNum(tagNum);
   }

   @Override
   public List<RecipeVO> getCategoryCode(Long categoryNo) {
	   log.info("getList..........");
	      List<RecipeVO> list = recipeMapper.getCategoryCode(categoryNo);
	      if(list!=null) {
	    	  list.forEach(a->a.setContentList(getCon(a.getRno())));
	      }
      return list;
   }
   
   @Override
   public List<CategoryVO> getCategoryNamebyPrevCode(Long categoryNo) {
      return categoryMapper.getCategoryNamebyPrevCode(categoryNo);
   }


   

   @Transactional
   @Override
   public void register_w(RecipeVO recipe)
   {
	   if(recipe!=null) {
	      Long rno = register(recipe);
	      
	      for(int i=0; i<recipe.getContentList().size(); i++)
	      {
	         recipe.getContentList().get(i).setRno(rno);
	         contentMapper.insert(recipe.getContentList().get(i));
	      }
	   }
   }


   @Override
   public boolean isMyRecipe(Long rno, Long userNo) {
      // TODO Auto-generated method stub
	  Long authorNo = recipeMapper.getUserNoByRno(rno);
	  if(authorNo!=null) {
		  return authorNo.equals(userNo);
	  }
	  return false;
   }


	@Override
	public List<TagVO> getTagNameList() {
		return recipeMapper.getTagNameList();
	}
	
	@Override
	public RecipeVO getLatestRecipe() {
		// TODO Auto-generated method stub
		Long rno = recipeMapper.getLatestRno();
		if(rno==null) return null;
		RecipeVO tmpRecipe = recipeMapper.read(rno);
		if(tmpRecipe==null) return null;
		return recipeMapper.read(rno);
	}

	@Override
	public int checkCode(Long categoryNo) {
		return categoryMapper.checkCode(categoryNo);
	}

	@Override
	public List<SimpleRecipeDTO> getSimpeRecipeByCategory(Long categoryNoLong) {
		// TODO Auto-generated method stub
		List<RecipeVO> list = getCategoryCode(categoryNoLong);
		if(list==null) return null;
		List<SimpleRecipeDTO> result = new ArrayList<>();
		list.forEach(a->result.add(ModelDTOFactory.getSimpleRecipe(a)));
		return result;
	}


}