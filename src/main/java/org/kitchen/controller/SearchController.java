package org.kitchen.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kitchen.domain.Criteria;
import org.kitchen.domain.PageDTO;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;
import org.kitchen.service.RecipeService;
import org.kitchen.service.SearchService;
import org.kitchen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;
import net.sf.json.JSONArray;

//지호: null값 유효성체크 0711
@Controller
@Log4j
@RequestMapping("/search/*")
public class SearchController {
	
	@Autowired
	SearchService searchService;
	@Autowired
	RecipeService recipeService;
	@Autowired
	UserService userService; 
	@GetMapping("/result")
	public String searchList(Criteria cri, Model model) {
		
		if(cri == null) { return wrongAccess(model); }
		String type = cri.getType();
		//String more = cri.getWhere();
		model.addAttribute("tag",recipeService.getTagNameList());
		model.addAttribute("category", searchService.read());
//		switch (type) {
//		case "T":
//			model.addAttribute("list", searchService.getSimpleRecipeList(cri));
//			break;
//		case "W":
//			model.addAttribute("list_user", searchService.getUserList(cri));
//			break;
//		case "Tag":
//			model.addAttribute("list_tag", searchService.getTagNum(cri));
//			break;
//		case "A":
//			
//			break;
//		}
		model.addAttribute("list", searchService.getSimpleRecipeList(cri));
		model.addAttribute("list_user", searchService.getUserList(cri));
		model.addAttribute("list_tag", searchService.getTagNum(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, 100));
		log.info("list : " + cri);
		return "/search/result";
	}

	@GetMapping("/user")
	public void userList(Criteria cri, Model model) {
		model.addAttribute("userSearch", searchService.getUserListById(cri));
	}

	@GetMapping("/detail")
	public String getMoreList(Criteria cri, Model model) {
		if(cri == null) { return wrongAccess(model); }
		log.info("list : " + cri);
		String more = cri.getWhere();
		int total = 0;
		switch (more) {
		case "recipe":
			model.addAttribute("moreList", searchService.getSimpleRecipeMoreList(cri));
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
			if(list == null) { return wrongAccess(model); }
			model.addAttribute("moreList", list);
			total = list.size();
		}
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		return "/search/detail";
	}
	

	private String wrongAccess(Model model) {
		// TODO Auto-generated method stub
		model.addAttribute("result", "잘못된 접근입니다.");
		return "/error";
	}

	private String wrongAccess(Model model, String string) {
		// TODO Auto-generated method stub
		model.addAttribute("result", string);
		return "/error";
	}

	private boolean isNumeric(String no) {
		try {
			double d = Double.parseDouble(no);
		} catch (NumberFormatException nfe) {
			return false;
		}
		return true;
	}
	
}
