package org.kitchen.controller;

import org.kitchen.service.RecipeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

//지호: null값 유효성체크 0711
@Controller
@Log4j
@RequestMapping("/test/*")
public class TestController {

	@Autowired
	private RecipeService recipeService;

	@GetMapping("/category")
	public void list(Long categoryNo, Model model) {
		if (categoryNo == null) {
			model.addAttribute("list", recipeService.getList());
		} else {
			model.addAttribute("list", recipeService.getCategoryCode(categoryNo));
		}
	}

}
