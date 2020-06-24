package org.kitchen.controller;

import org.kitchen.service.RecipeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/recipeBoard/*")
@AllArgsConstructor
public class RecipeController_w {
	private RecipeService service;
}
