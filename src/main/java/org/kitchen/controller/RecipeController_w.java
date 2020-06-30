package org.kitchen.controller;

import org.kitchen.domain.Criteria_w;
import org.kitchen.domain.PageDTO_w;
import org.kitchen.service.RecipeService_w;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/recipeBoard/*")
public class RecipeController_w {

	@Setter(onMethod_ = {@Autowired})
	private RecipeService_w service;
	
//	@GetMapping("/list_w")
//	public void list(Model model)
//	{
//		log.info("list");
//		model.addAttribute("list_w", service.getList());
//		
//	}
	@GetMapping("/index_w")
	public void search(Criteria_w cri, Model model)
	{
		model.addAttribute("pageMaker", new PageDTO_w(cri, 100));
		
	}
	
	@GetMapping("/morelist")
	public void getMoreList(Criteria_w cri, Model model)
	{
		String more = cri.getWhere();
		int total = 0;
		switch(more)
		{
		case "recipe":
			model.addAttribute("moreList", service.moreRecipeList(cri));
			total = service.getTotalRecipe(cri);
			break;
		case "user":
			model.addAttribute("moreList_u", service.moreUserList(cri));
			total = service.getTotalUser(cri);
			break;
		case "tag":
			
		}
		model.addAttribute("pageMaker", new PageDTO_w(cri, total));
	}
	
	
	
	@GetMapping("/list_w")
	public void list(Criteria_w cri, Model model)
	{	
		
	String type = cri.getType();
	String more = cri.getWhere();
	System.out.println("more@@@"+more);
	switch(type) {
	case "T":
		model.addAttribute("list_w", service.getList(cri));
		break;
	case "W":
		model.addAttribute("list_user", service.getUserList(cri));
		break;
	case "Tag":
		model.addAttribute("list_tag", service.getTagNum(cri));
		break;
	case "A":
		model.addAttribute("list_w", service.getList(cri));
		model.addAttribute("list_user", service.getUserList(cri));
		model.addAttribute("list_tag", service.getTagNum(cri));
		break;
	}
	model.addAttribute("pageMaker", new PageDTO_w(cri, 100));
		log.info("list : " + cri);
//		if(cri.getKeyword()!=null||cri.getKeyword()!="") {	
//			model.addAttribute("list_tag", service.getTagNum(cri));
		
	}
	 


}
