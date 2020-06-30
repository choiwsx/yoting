package org.kitchen.controller;

import java.util.List;

import org.kitchen.domain.ContentVO;
import org.kitchen.domain.RecipeVO;
import org.kitchen.service.RecipeService_J;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/recipe/*")
public class RecipeController_J {
	
	@Autowired
	private RecipeService_J service;
	
	@GetMapping("/list")
	public void list(Model model)
	{
		log.info("list");
		model.addAttribute("list", service.getList());
	}
	
	@PostMapping("/register")
	public String register(RecipeVO recipe, RedirectAttributes rttr, MultipartHttpServletRequest mttr)
	{
		log.info("register : " + recipe);
		
//		recipe.setThumbnail(mttr.);
		service.register(recipe);
		rttr.addFlashAttribute("result", recipe.getRno());
		
		
		return "redirect:/recipe/list";
	}
	
	@GetMapping("/get")
	public void get(Long rno, Model model)
	{
		log.info("/get");
		model.addAttribute("recipe", service.get(rno));
		model.addAttribute("content", service.getCon(rno));
	}
	
	@PostMapping("/modify")
	public String modify(RecipeVO recipe, ContentVO content, RedirectAttributes rttr)
	{
		log.info("modify: " + recipe);
		log.info("modify: " + content);
		
		if(service.modify(recipe) && service.ModifyCon(content))
		{
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/recipe/modify";
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
}