package org.kitchen.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.kitchen.domain.CategoryVO;
import org.kitchen.domain.Criteria;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.SimpleProfileDTO;
import org.kitchen.domain.ModelDTOFactory;
import org.kitchen.domain.UserVO;
import org.kitchen.mapper.CategoryMapper;
import org.kitchen.mapper.RecipeMapper;
import org.kitchen.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class SearchServiceImpl implements SearchService {
	
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private RecipeMapper recipeMapper;
	@Autowired
	private CategoryMapper categoryMapper;

//	REcipeSERACHMethods

	@Override
	public int getTotalUserCount(Criteria cri) {
		// TODO Auto-generated method stub
		return recipeMapper.getTotalUserCount(cri);
	}

	@Override
	public int getTotalTagCount(Criteria cri) {
		// TODO Auto-generated method stub
		List<Long> tno = recipeMapper.getTagNum(cri);

		HashSet<Long> rno = new HashSet<Long>();
		List<RecipeVO> recipeList = null;
		List<Long> rnoList = null;
		if (tno != null) {
			recipeList = new ArrayList<RecipeVO>();
			rnoList = new ArrayList<Long>();
			for (int i = 0; i < tno.size(); i++) {
				List<Long> tmp = recipeMapper.getRnoByTagNum(tno.get(i));
				for (int j = 0; j < tmp.size(); j++) {
					rno.add(tmp.get(j));
				}
			}
			Object[] arr = rno.toArray();
			for (int i = 0; i < rno.size(); i++) {
				String stringToConvert = String.valueOf(arr[i]);
				Long convertedLong = Long.parseLong(stringToConvert);
				rnoList.add(convertedLong);
//			recipeList = recipeMapper.getRecipeByRno(listArr);
			}
			System.out.println("recipeListSize=" + recipeList.size());
			cri.setRnoList(rnoList);
			return recipeMapper.getTotalTagCount(cri).size();
		}
		return 0;
	}

	@Override
	public List<RecipeVO> moreTagList(Criteria cri) {
		// TODO Auto-generated method stub
		List<Long> tno = recipeMapper.getTagNum(cri);

		HashSet<Long> rno = new HashSet<Long>();
		List<RecipeVO> recipeList = null;
		List<Long> rnoList = null;
		if (tno != null) {
			recipeList = new ArrayList<RecipeVO>();
			rnoList = new ArrayList<Long>();
			for (int i = 0; i < tno.size(); i++) {
				List<Long> tmp = recipeMapper.getRnoByTagNum(tno.get(i));
				for (int j = 0; j < tmp.size(); j++) {
					rno.add(tmp.get(j));
				}
			}
			Object[] arr = rno.toArray();
			for (int i = 0; i < rno.size(); i++) {
				String stringToConvert = String.valueOf(arr[i]);
				Long convertedLong = Long.parseLong(stringToConvert);
				rnoList.add(convertedLong);
//					recipeList = recipeMapper.getRecipeByRno(listArr);
			}
			System.out.println("@@@@@@@@@" + rnoList);
			cri.setRnoList(rnoList);
			if (rnoList.size() > 0)
				return recipeMapper.getRecipeByRnoWithPaging(cri);
		}
		return recipeList;
	}

	@Override
	public List<RecipeVO> moreRecipeList(Criteria cri) {
		// TODO Auto-generated method stub
		return recipeMapper.getRecipeListWithPaging(cri);
	}

	@Override
	public int getTotalRecipeCount(Criteria cri) {
		// TODO Auto-generated method stub
		return recipeMapper.getTotalRecipeCount(cri);
	}

	@Override
	public List<UserVO> moreUserList(Criteria cri) {
		// TODO Auto-generated method stub
		return recipeMapper.getUserListWithPaging(cri);
	}

	@Override
	public List<RecipeVO> getTagNum(Criteria cri) {
		// TODO Auto-generated method stub
		List<Long> tno = recipeMapper.getTagNum(cri);

		HashSet<Long> rno = new HashSet<Long>();
		List<RecipeVO> recipeList = null;
		List<Long> rnoList = null;
		if (tno != null) {
			recipeList = new ArrayList<RecipeVO>();
			rnoList = new ArrayList<Long>();
			for (int i = 0; i < tno.size(); i++) {
				List<Long> tmp = recipeMapper.getRnoByTagNum(tno.get(i));
				for (int j = 0; j < tmp.size(); j++) {
					rno.add(tmp.get(j));
				}
			}
			Object[] arr = rno.toArray();
			for (int i = 0; i < rno.size(); i++) {
				String stringToConvert = String.valueOf(arr[i]);
				Long convertedLong = Long.parseLong(stringToConvert);
				rnoList.add(convertedLong);
			}
			if (rnoList.size() > 0)
				return recipeMapper.getRecipeByRno(rnoList);
		}
		return recipeList;
	}

	@Override
	public List<RecipeVO> getRecipeList(Criteria cri) {
		log.info("get list with criteria: " + cri);
		return recipeMapper.getListWithPaging(cri);
	}

	@Override
	public List<UserVO> getUserList(Criteria cri) {
		// TODO Auto-generated method stub
		return recipeMapper.getUserList(cri);
	}

//	UserSearchMEthod

	@Override
	public List<UserVO> getUserListById(Criteria cri) {
		return userMapper.getInfobyId(cri);
	}

	@Override
	public List<RecipeVO> searchUserRecipeList(Criteria cri) {
		// TODO Auto-generated method stub
		return recipeMapper.searchUserRecipeList(cri);
	}
	
	@Override
	public List<RecipeVO> getUserRecipeList(Long userNo) {
		// TODO Auto-generated method stub
		return recipeMapper.getUserRecipeList(userNo);
	}

	@Override
	public List<CategoryVO> read() {
		return categoryMapper.read();
	}

	//실패.안됑
	@Override
	public List<SimpleProfileDTO> getHotUserList(int length) {
		// TODO Auto-generated method stub
		//팔로워 수가 많은 순서대로 렝스만큼 유저 넘버를 가져온다
		List<Long> userNoList = userMapper.getHotUserList(length);
		userNoList.forEach(a -> log.info(a));
		List<SimpleProfileDTO> result = new ArrayList<>();
		for(int i = 0; i<userNoList.size(); i++) {
			result.add(ModelDTOFactory.getSimpleProfile(userMapper.selectByNo(userNoList.get(i))));
		}
		//유저 찾아서 준다.
		return result;
	}


}
