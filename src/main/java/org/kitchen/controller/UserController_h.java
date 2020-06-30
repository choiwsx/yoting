package org.kitchen.controller;

import org.kitchen.domain.UserVO;
import org.kitchen.exception_h.DuplicatedUserException;
import org.kitchen.exception_h.NoUserFoundException;
import org.kitchen.exception_h.UserMapperFailException;
import org.kitchen.service.UserService_h;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user-h/*")
@SessionAttributes("user")
public class UserController_h {
	
	@Autowired
	private UserService_h service;
	
	@GetMapping("/registration")
	public String registrationForm() {
		return "user-h/registration";	//jsp에서 result확인	
	}
	
	@PostMapping("/registration")
	public ModelAndView validateuser(UserVO user) {
		ModelAndView modelAndView = new ModelAndView();
		log.info("#############"+user);
		try {
			if(service.isLegitNewUser(user)) {
				modelAndView.setViewName("user-h/newprofile");
				modelAndView.addObject("user", user);
				return modelAndView;
			}
		} catch (DuplicatedUserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		modelAndView.addObject("result", "duplicatedUser");
		modelAndView.setViewName("/user-h/registration");
		return modelAndView;
	}
	
	@GetMapping("/newprofile")
	public String newProfileForm() {
		return "user-h/newprofile";
	}
	
	@PostMapping("/newprofile")
	public ModelAndView registeruser(@ModelAttribute("user") UserVO user, ModelAndView modelAndView, SessionStatus sessionStatus) {		
		try {
			if(service.isLegitNewUser(user)) {
				log.info("@@@@@@@@"+user);
				service.registerNewUser(user);
				user.setUserPwd(null);
				modelAndView.addObject("user", user);
				modelAndView.setViewName("redirect:/user-h/welcome"); 
				return modelAndView;
			}
		} catch (DuplicatedUserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			modelAndView.addObject("result", "duplicatedUser");
			sessionStatus.setComplete();
		} catch (UserMapperFailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			modelAndView.addObject("result", "userMapperFail");
			sessionStatus.setComplete();
		}
		modelAndView.setViewName("redirect:/user-h/newprofile");
		return modelAndView;
	}
	
	@GetMapping("/welcome")
	public String welcomePage() {
		return "/user-h/welcome";
	}
	
	@GetMapping("/verify")
	public String verify(String key, String userno) {
		try {
			if(service.verifyEmail(userno, key)) {
				service.activateUser(Long.valueOf(userno));
				return "/user-h/good";
			}
		} catch (NoUserFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/user-h/fail";
	}
	
	@GetMapping("/list")
	public ModelAndView showList() {
		ModelAndView modelAndView = new ModelAndView("/user-h/list");
		try {
			modelAndView.addObject("list", service.getTotalList());
		} catch (NoUserFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return modelAndView;
	}
	
	@GetMapping("/deluser")
	public String delUser(Long userno) {
		try {
			service.deleteUserByNo(userno);
		} catch (NoUserFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UserMapperFailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/user-h/list";
	}
}
