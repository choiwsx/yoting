package org.kitchen.controller;

import org.kitchen.service.RecipeService_k;
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
public class RecipeController_k {

	@Setter(onMethod_ = { @Autowired })
	private RecipeService_k service;


	@GetMapping("/category")
	public void list(Long categoryNo ,Model model)
	{
		if(categoryNo == null) {
			model.addAttribute("list", service.getList());
		}else {
			model.addAttribute("list", service.getCategoryCode(categoryNo));
		}
		    
		
	}
	
	@GetMapping("/NewFile")
	public void list(Model model)
	{
			model.addAttribute("NewFile");
		    
		
	}


}

