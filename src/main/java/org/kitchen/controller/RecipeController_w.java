package org.kitchen.controller;

import org.kitchen.domain.Criteria_w;
import org.kitchen.domain.PageDTO_w;
import org.kitchen.service.RecipeService_w;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@GetMapping("/list_w")
	public void list(Criteria_w cri, Model model)
	{
		log.info("list : " + cri);
		model.addAttribute("list_w", service.getList(cri));
		model.addAttribute("list_user", service.getUserList(cri));
		if(cri.getKeyword()!=null||cri.getKeyword()!="") {	
			model.addAttribute("list_tag", service.getTagNum(cri));
		}
		model.addAttribute("pageMaker", new PageDTO_w(cri, 100));
	}
	 


}
