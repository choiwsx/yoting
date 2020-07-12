package org.kitchen.controller;

import javax.servlet.http.HttpSession;

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

// 지호: null값 유효성체크 0711
@RequestMapping("/admin/*")
@Controller
public class AdminController {
	
	@Autowired
	UserService userService;
	@Autowired
	RecipeService recipeService;
	
	@GetMapping("/userList")
	public String userList(Model model, HttpSession session) {
		if( session.getAttribute("userNo")==null || (! ( ((Long)session.getAttribute("userNo")).equals(1L) ) ) ) {
			return wrongAccess(model);
		}
		model.addAttribute("list", userService.getTotalList());
		return "/admin/userList";
	}
	
	@GetMapping("/recipeList")
	public String recipeList(Model model, HttpSession session) {
		if( session.getAttribute("userNo")==null || (! ( ((Long)session.getAttribute("userNo")).equals(1L) ) ) ) {
			return wrongAccess(model);
		}
		if(! ( ((Long)session.getAttribute("userNo")).equals(1L) ) ) {
			return wrongAccess(model);
		}
		model.addAttribute("list", recipeService.getList());
		return "/admin/recipeList";
	}
	
	@GetMapping("modiUser")
	public String modiUser(Model model, String userNo, HttpSession session) {
		if( session.getAttribute("userNo")==null || (! ( ((Long)session.getAttribute("userNo")).equals(1L) ) ) ) {
			return wrongAccess(model);
		}
		if(userNo==null) return wrongAccess(model);
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
		return "/admin/modiUser";
	}
	

	@PostMapping("/modiUser")
	public String modiList(Model model, UserVO user, HttpSession session) {
		if( session.getAttribute("userNo")==null || (! ( ((Long)session.getAttribute("userNo")).equals(1L) ) ) ) {
			return wrongAccess(model);
		}
		if(user==null) return wrongAccess(model);
		try {
			userService.modifyUser(user);
		} catch (UserMapperFailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("result", "수정불가한 유저 혹은 항목입니다.");
			return "/error";
		}
		model.addAttribute("result","유저 정보가 수정되었습니다.");
		return "/good";
	}
	
	
	@GetMapping("/delUser")
	public String delUser(Model model, String userNo, HttpSession session) {
		if( session.getAttribute("userNo")==null || (! ( ((Long)session.getAttribute("userNo")).equals(1L) ) ) ) {
			return wrongAccess(model);
		}
		if(userNo==null) return wrongAccess(model);
		try {
			userService.deleteUserByNo(Long.valueOf(userNo));
		} catch (UserMapperFailException e) {
			e.printStackTrace();
			model.addAttribute("result", "삭제 불가 유저에요");
			return "/error";
		} catch (NumberFormatException e) {
			return wrongAccess(model);
		}
		return "/admin/userList";
	}
	
	
	@GetMapping("/modiRecipe")
	public String modiRecipe(Model model, String rno, HttpSession session) {
		if( session.getAttribute("userNo")==null || (! ( ((Long)session.getAttribute("userNo")).equals(1L) ) ) ) {
			return wrongAccess(model);
		}
		if(rno==null) return wrongAccess(model);
		try {
			RecipeVO recipe = recipeService.get(Long.valueOf(rno));
			if(recipe==null) {
				model.addAttribute("result", "수정할 레시피가 없어요");
				return "/error";
			}
			model.addAttribute("recipe", recipe);
			return "/admin/modiRecipe";
		} catch (NumberFormatException e) {
			return wrongAccess(model);
		}		
	}
	
	@PostMapping("modiRecipe")
	public String modiRecipe(Model model, RecipeVO recipe, HttpSession session) {
		if( session.getAttribute("userNo")==null || (! ( ((Long)session.getAttribute("userNo")).equals(1L) ) ) ) {
			return wrongAccess(model);
		}
		if(recipe==null) return wrongAccess(model);
		if(recipeService.get(recipe.getRno())==null) {
			model.addAttribute("result", "수정할 레시피가 없어요");
			return "/error";
		}
		recipeService.modify(recipe);
		return "/admin/recipeList";
	}
	
	@GetMapping("/delRecipe")
	public String delRecipe(Model model, String rno, HttpSession session) {
		if( session.getAttribute("userNo")==null || (! ( ((Long)session.getAttribute("userNo")).equals(1L) ) ) ) {
			return wrongAccess(model);
		}
		if(rno==null) return wrongAccess(model);
		RecipeVO recipe = recipeService.get(Long.valueOf(rno));
		if(recipe==null) {
			model.addAttribute("result", "삭제할 레시피가 없어요");
			return "/error";
		}
		recipeService.remove(Long.valueOf(rno));
		return "redirect:/admin/recipeList";
	}
	
	private String wrongAccess(Model model) {
		// TODO Auto-generated method stub
		model.addAttribute("result", "잘못된 접근입니다.");
		return "/error";
	}

}
