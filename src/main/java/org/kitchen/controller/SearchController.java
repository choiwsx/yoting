package org.kitchen.controller;

import java.util.List;

import org.kitchen.domain.Criteria;
import org.kitchen.domain.PageDTO;
import org.kitchen.domain.RecipeVO;
import org.kitchen.service.RecipeService;
import org.kitchen.service.SearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/search/*")
public class SearchController {
	
	@Autowired
	SearchService searchService;
	@Autowired
	RecipeService recipeService; 
	@GetMapping("/result")
	public void searchList(Criteria cri, Model model) {
		
		String type = cri.getType();
		//String more = cri.getWhere();
		model.addAttribute("tag",recipeService.getTagNameList());
		model.addAttribute("category", searchService.read());
		switch (type) {
		case "T":
			model.addAttribute("list", searchService.getRecipeList(cri));
			break;
		case "W":
			model.addAttribute("list_user", searchService.getUserList(cri));
			break;
		case "Tag":
			model.addAttribute("list_tag", searchService.getTagNum(cri));
			break;
		case "A":
			model.addAttribute("list", searchService.getRecipeList(cri));
			model.addAttribute("list_user", searchService.getUserList(cri));
			model.addAttribute("list_tag", searchService.getTagNum(cri));
			break;
		}
		model.addAttribute("pageMaker", new PageDTO(cri, 100));
		log.info("list : " + cri);
	}

	@GetMapping("/user")
	public void userList(Criteria cri, Model model) {
		model.addAttribute("userSearch", searchService.getUserListById(cri));
	}

	@GetMapping("/detail")
	public void getMoreList(Criteria cri, Model model) {
		log.info("list : " + cri);
		String more = cri.getWhere();
		int total = 0;
		switch (more) {
		case "recipe":
			model.addAttribute("moreList", searchService.moreRecipeList(cri));
			total = searchService.getTotalRecipeCount(cri);
			break;
		case "user":
			cri.setAmount(6);
			model.addAttribute("moreList_u", searchService.moreUserList(cri));
			total = searchService.getTotalUserCount(cri);
			break;
		case "tag":
			model.addAttribute("moreList", searchService.moreTagList(cri));
			total = (int) searchService.getTotalTagCount(cri);
			break;
		case "profile":
			List<RecipeVO> list = searchService.searchUserRecipeList(cri);
			model.addAttribute("moreList", list);
			total = list.size();
		}
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

}
