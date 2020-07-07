package org.kitchen.controller;

import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;
import org.kitchen.exception.UserMapperFailException;
import org.kitchen.service.RecipeService;
import org.kitchen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin/*")
@Controller
public class AdminController {
	
	@Autowired
	UserService userService;
	@Autowired
	RecipeService recipeService;
	
	@GetMapping("/userList")
	public void userList(Model model) {
		model.addAttribute("list", userService.getTotalList());
	}
	
	@GetMapping("/recipeList")
	public void recipeList(Model model) {
		model.addAttribute("list", recipeService.getList());
	}
	
	@GetMapping("modiUser")
	public String modiUser(Model model, String userNo) {
		try {
			if(userService.getUserByNo(Long.valueOf(userNo))==null) {
				model.addAttribute("result", "수정할 유저가 없어요");
				return "/error";
			}
		} catch (NumberFormatException e) {
			model.addAttribute("result", "잘못된 접근입니다.");
			return "/error";
		}
		model.addAttribute("user", userService.getUserByNo(Long.valueOf(userNo)));
		return "/admin/recipeList";
	}
	
	@PostMapping("/modiUser")
	public String modiList(Model model, UserVO user) {
		try {
			userService.modifyUser(user);
		} catch (UserMapperFailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("result", "수정불가한 유저 혹은 항목입니다.");
			return "/error";
		}
		model.addAttribute("user", user);
		return "/admin/modiUser";
	}
	
	
	@GetMapping("/delUser")
	public String delUser(Model model, Long userno) {
		try {
			userService.deleteUserByNo(userno);
		} catch (UserMapperFailException e) {
			e.printStackTrace();
			model.addAttribute("result", "삭제 불가 유저에요");
			return "/error";
		}
		return "/admin/userList";
	}
	
	
	@GetMapping("/modiRecipe")
	public String modiRecipe(Model model, Long rno) {
		RecipeVO recipe = recipeService.get(rno);
		if(recipe==null) {
			model.addAttribute("result", "수정할 레시피가 없어요");
			return "/error";
		}
		recipeService.remove(rno);
		return "/admin/modiRecipe";
	}
	
	@PostMapping("modiRecipe")
	public String modiRecipe(Model model, RecipeVO recipe) {
		if(recipeService.get(recipe.getRno())==null) {
			model.addAttribute("result", "수정할 레시피가 없어요");
			return "/error";
		}
		recipeService.modify(recipe);
		return "/admin/recipeList";
	}
	
	@GetMapping("/delRecipe")
	public String delRecipe(Model model, Long rno) {
		RecipeVO recipe = recipeService.get(rno);
		if(recipe==null) {
			model.addAttribute("result", "삭제할 레시피가 없어요");
			return "/error";
		}
		recipeService.remove(rno);
		return "/admin/recipeList";
	}
	

}
