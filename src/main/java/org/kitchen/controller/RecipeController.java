package org.kitchen.controller;

import org.kitchen.domain.ContentVO;
import org.kitchen.domain.Criteria;
import org.kitchen.domain.PageDTO;
import org.kitchen.domain.RecipeVO;
import org.kitchen.service.RecipeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/recipe/*")
public class RecipeController {
	
	@Autowired
	private RecipeService service;

	@GetMapping("/register")
	public void register() {

	}

	@PostMapping("/register")
	public String register(RecipeVO recipe, ContentVO content, RedirectAttributes rttr) {
		log.info("register : " + recipe);

//		service.register(recipe);
//		service.registerCon(content);
		service.register(recipe, content);

		rttr.addFlashAttribute("result", recipe.getRno());
		rttr.addFlashAttribute("resultCon", content.getRno());

		return "redirect:/recipe/list";
	}

	@GetMapping("/get")
	public void get(Long rno, Model model) {
		log.info("/get");
		model.addAttribute("recipe", service.get(rno));
		model.addAttribute("content", service.getCon(rno));
	}

	@PostMapping("/modify")
	public String modify(RecipeVO recipe, ContentVO content, RedirectAttributes rttr) {
		log.info("modify: " + recipe);
		log.info("modify: " + content);

		if (service.modify(recipe) && service.ModifyCon(content)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/recipe/modify";
	}

	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		model.hashCode();
		model.addAttribute("list", service.getList());
	}

}
