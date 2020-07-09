package org.kitchen.controller;

import org.kitchen.service.RecipeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/test/*")
public class TestController {

	@Autowired
	private RecipeService service;

	@GetMapping("/category")
	public void list(Long categoryNo, Model model) {
		if (categoryNo == null) {
			model.addAttribute("list", service.getList());
		} else {
			model.addAttribute("list", service.getCategoryCode(categoryNo));
		}
	}

}
