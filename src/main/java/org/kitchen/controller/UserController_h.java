package org.kitchen.controller;

import java.util.Locale;

import org.kitchen.domain.UserVO;
import org.kitchen.exception_h.DuplicatedUserException;
import org.kitchen.service.RecipeService_w;
import org.kitchen.service.UserService_h;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user-h/*")
public class UserController_h {
	
	@Setter(onMethod_ = {@Autowired})
	private UserService_h service;
	
	@GetMapping("/registration")
	public String form() {
		return "user-h/registration";		
	}
	
	@PostMapping("/registration")
	public String register(@RequestParam("userId") String userId, @RequestParam("userPwd") String userPwd, @RequestParam("email") String email, @RequestParam("emailSub") String emailSub, RedirectAttributes rttr) {
		UserVO user = new UserVO();
		user.setUserId(userId);
		user.setUserPwd(userPwd);
		user.setEmail(email);
		user.setEmailSub(emailSub.equals("1")?true:false);
		
		log.info("#############"+user);
		try {
			if(service.isLegitNewUser(user)) {
				rttr.addFlashAttribute("user", user);
				return "redirect:/user-h/newprofile";
			}
		} catch (DuplicatedUserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		rttr.addFlashAttribute("result", "fail");
		return "redirect:/user-h/registration";
	}
}
