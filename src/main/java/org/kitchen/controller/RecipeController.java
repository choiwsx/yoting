package org.kitchen.controller;


import javax.servlet.http.HttpServletRequest;

import org.kitchen.domain.ContentVO;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;
import org.kitchen.exception.NoUserFoundException;
import org.kitchen.service.RecipeService;
import org.kitchen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/recipe/*")
public class RecipeController {
	
	@Autowired
	private RecipeService recipeService;
	@Autowired
	private UserService userService;

	@GetMapping("/register")
	public void register() {

	}
		

	@PostMapping("/register")
	public String register(RecipeVO recipe, ContentVO content, RedirectAttributes rttr) {
		log.info("register : " + recipe);

//		recipeService.register(recipe);
//		recipeService.registerCon(content);
		recipeService.register(recipe, content);

		rttr.addFlashAttribute("result", recipe.getRno());
		rttr.addFlashAttribute("resultCon", content.getRno());

		return "redirect:/recipe/list";
	}
	
	@GetMapping("/registration")
	public void register2form(Model model) {
		model.addAttribute("recipe", new RecipeVO());
	}
	
	@PostMapping("/registrationTest")
	public @ModelAttribute("recipe") RecipeVO register2save(@ModelAttribute("recipe") RecipeVO recipe) {
		//recipeService에 저장하기
		//recipeService.register(recipe, recipe.getContentList());
		return recipe;
	}

	@GetMapping("/get")
	public void get(Long rno, Model model) {
		log.info("/get");
		model.addAttribute("recipe", recipeService.get(rno));
		model.addAttribute("content", recipeService.getCon(rno));
	}

	@PostMapping("/modify")
	public String modify(RecipeVO recipe, ContentVO content, RedirectAttributes rttr) {
		log.info("modify: " + recipe);
		log.info("modify: " + content);

		if (recipeService.modify(recipe) && recipeService.ModifyCon(content)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/recipe/modify";
	}

	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		model.hashCode();
		model.addAttribute("list", recipeService.getList());
	}
	
	@GetMapping("detail")
	public void detail(Model model, Long rno) {
		RecipeVO recipe = recipeService.get(rno);
		try {
			model.addAttribute("author", userService.getUserByNo(recipe.getUserNo()));
		} catch (NoUserFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			UserVO author = new UserVO();
			author.setNickName("정보 없음");
			author.setUserId("#");
			author.setBio("정보를 찾을 수 없는 유저");
			model.addAttribute("author", author);
		}
		model.addAttribute("recipe", recipe);
		model.addAttribute("contentList", recipeService.getCon(rno));
	}
	
	@GetMapping("del")
	public String delelete(HttpServletRequest request, Model model, Long rno) {
		if(recipeService.remove(rno)) {
			model.addAttribute("result", "success");
		} else {
			model.addAttribute("result", "fail");
		}
		String referer = request.getHeader("Referer");
	    return "redirect:"+ referer;
	}
	
	@GetMapping("/category")
	public void list(Long categoryNo, Model model) {
		if (categoryNo == null) {
			model.addAttribute("list", recipeService.getList());
		} else {
			model.addAttribute("list", recipeService.getCategoryCode(categoryNo));
		}
	}

}
