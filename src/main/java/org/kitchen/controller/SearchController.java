package org.kitchen.controller;

import java.util.List;

import org.kitchen.domain.Criteria;
import org.kitchen.domain.PageDTO;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;
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
	SearchService service;

	@GetMapping("/result")
	public void searchList(Criteria cri, Model model) {
		String type = cri.getType();
		String more = cri.getWhere();
		System.out.println("more@@@" + more);
		model.addAttribute("category", service.read());
		switch (type) {
		case "T":
			model.addAttribute("list", service.getRecipeList(cri));
			break;
		case "W":
			model.addAttribute("list_user", service.getUserList(cri));
			break;
		case "Tag":
			model.addAttribute("list_tag", service.getTagNum(cri));
			break;
		case "A":
			model.addAttribute("list", service.getRecipeList(cri));
			model.addAttribute("list_user", service.getUserList(cri));
			model.addAttribute("list_tag", service.getTagNum(cri));
			break;
		}
		model.addAttribute("pageMaker", new PageDTO(cri, 100));
		log.info("list : " + cri);
	}

	@GetMapping("/user")
	public void userList(Criteria cri, Model model) {
		model.addAttribute("userSearch", service.getUserListById(cri));
	}

	@GetMapping("/detail")
	public void getMoreList(Criteria cri, Model model) {
		log.info("list : " + cri);
		String more = cri.getWhere();
		int total = 0;
		switch (more) {
		case "recipe":
			model.addAttribute("moreList", service.moreRecipeList(cri));
			total = service.getTotalRecipeCount(cri);
			break;
		case "user":
			cri.setAmount(6);
			model.addAttribute("moreList_u", service.moreUserList(cri));
			total = service.getTotalUserCount(cri);
			break;
		case "tag":
			model.addAttribute("moreList", service.moreTagList(cri));
			System.out.println("cri=" + cri);
			total = (int) service.getTotalTagCount(cri);
			System.out.println("totalcount=" + total);
			break;
		case "profile":
			List<RecipeVO> list = service.searchUserRecipeList(cri);
			model.addAttribute("moreList", list);
			total = list.size();
		}
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

}
