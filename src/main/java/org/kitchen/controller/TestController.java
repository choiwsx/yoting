package org.kitchen.controller;

import org.kitchen.service.RecipeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test/*")
public class TestController {
	
	private static final Logger log = LoggerFactory.getLogger(TestController.class);

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
