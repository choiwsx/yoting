package org.kitchen.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.kitchen.domain.Criteria_w;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;
import org.kitchen.mapper.RecipeMapper_w;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class RecipeServiceImpl_w implements RecipeService_w {
	
	@Setter(onMethod_ = @Autowired)
	private RecipeMapper_w mapper;

	@Override
	public List<RecipeVO> getList(Criteria_w cri) {
		log.info("get list with criteria: " + cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public List<UserVO> getUserList(Criteria_w cri) {
		// TODO Auto-generated method stub
		return mapper.getUserList(cri);
	}

	@Override
	public List<?> getAll(Criteria_w cri) {
		// TODO Auto-generated method stub
		return mapper.getAll(cri);
	}

	@Override
	public List<RecipeVO> getTagNum(Criteria_w cri) {
		// TODO Auto-generated method stub
		List<Long> tno = mapper.getTagNum(cri);
		
		HashSet<Long> rno = new HashSet<Long>();
		List<RecipeVO> recipeList = null;
		List<Long> rnoList = null;
		if(tno!=null)
		{
			recipeList = new ArrayList<RecipeVO>();
			rnoList = new ArrayList<Long>();
			for(int i=0; i<tno.size(); i++) {
				List<Long> tmp = mapper.getRnoByTagNum(tno.get(i));
				for(int j=0; j<tmp.size(); j++)
				{
					rno.add(tmp.get(j));
				}
			}
			Object[] arr = rno.toArray();
			for(int i=0; i<rno.size(); i++) {
				String stringToConvert = String.valueOf(arr[i]);
				Long convertedLong = Long.parseLong(stringToConvert);
				rnoList.add(convertedLong);
//			recipeList = mapper.getRecipeByRno(listArr);
			}
			System.out.println("@@@@@@@@@"+rnoList);
			if(rnoList.size()>0)
				return mapper.getRecipeByRno(rnoList);
		}
		return recipeList;
	}

	@Override
	public List<Long> getRnoByTagNum(Long tagNum) {
		// TODO Auto-generated method stub
		return mapper.getRnoByTagNum(tagNum);
	}

	@Override
	public List<RecipeVO> moreRecipeList(Criteria_w cri) {
		// TODO Auto-generated method stub
		return mapper.getRecipeListWithPaging(cri);
	}

	@Override
	public int getTotalRecipe(Criteria_w cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalRecipeCount(cri);
	}

	@Override
	public List<UserVO> moreUserList(Criteria_w cri) {
		// TODO Auto-generated method stub
		return mapper.getUserListWithPaging(cri);
	}

	@Override
	public int getTotalUser(Criteria_w cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalUserCount(cri);
	}

	@Override
	public long getTotalTag(Criteria_w cri) {
		// TODO Auto-generated method stub
		List<Long> tno = mapper.getTagNum(cri);
		
		HashSet<Long> rno = new HashSet<Long>();
		List<RecipeVO> recipeList = null;
		List<Long> rnoList = null;
		if(tno!=null)
		{
			recipeList = new ArrayList<RecipeVO>();
			rnoList = new ArrayList<Long>();
			for(int i=0; i<tno.size(); i++) {
				List<Long> tmp = mapper.getRnoByTagNum(tno.get(i));
				for(int j=0; j<tmp.size(); j++)
				{
					rno.add(tmp.get(j));
				}
			}
			Object[] arr = rno.toArray();
			for(int i=0; i<rno.size(); i++) {
				String stringToConvert = String.valueOf(arr[i]);
				Long convertedLong = Long.parseLong(stringToConvert);
				rnoList.add(convertedLong);
//			recipeList = mapper.getRecipeByRno(listArr);
			}
			System.out.println("recipeListSize="+recipeList.size());
			cri.setRnoList(rnoList);
			return mapper.getTotalTagCount(cri).size();
		}
		return 0; 
	}

	@Override
	public List<RecipeVO> moreTagList(Criteria_w cri) {
		// TODO Auto-generated method stub
				List<Long> tno = mapper.getTagNum(cri);
				
				HashSet<Long> rno = new HashSet<Long>();
				List<RecipeVO> recipeList = null;
				List<Long> rnoList = null;
				if(tno!=null)
				{
					recipeList = new ArrayList<RecipeVO>();
					rnoList = new ArrayList<Long>();
					for(int i=0; i<tno.size(); i++) {
						List<Long> tmp = mapper.getRnoByTagNum(tno.get(i));
						for(int j=0; j<tmp.size(); j++)
						{
							rno.add(tmp.get(j));
						}
					}
					Object[] arr = rno.toArray();
					for(int i=0; i<rno.size(); i++) {
						String stringToConvert = String.valueOf(arr[i]);
						Long convertedLong = Long.parseLong(stringToConvert);
						rnoList.add(convertedLong);
//					recipeList = mapper.getRecipeByRno(listArr);
					}
					System.out.println("@@@@@@@@@"+rnoList);
					cri.setRnoList(rnoList);
					if(rnoList.size()>0)
						return mapper.getRecipeByRnoWithPaging(cri);
				}
				return recipeList;
	} 
	
	
	
	
}
