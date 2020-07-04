package org.kitchen.controller;

import org.kitchen.domain.UserVO;
import org.kitchen.exception.DuplicatedUserException;
import org.kitchen.exception.NoUserFoundException;
import org.kitchen.exception.UserMapperFailException;
import org.kitchen.service.RecipeService;
import org.kitchen.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/user/*")
@SessionAttributes("user")
public class UserController {
	
	private static final Logger log = LoggerFactory.getLogger(RecipeService.class);
	
	@Autowired
	private UserService service;
	
//	User Account Registration process
	@GetMapping("/registration")
	public void registrationForm() {
	}
	
	@PostMapping("/registration")
	public ModelAndView validateuser(UserVO user) {
		ModelAndView modelAndView = new ModelAndView();
		log.info("#############"+service.isLegitNewUser(user)+user);		
		if(service.isLegitNewUser(user)) {
			modelAndView.setViewName("user/newprofile");
			modelAndView.addObject("user", user);
		} else {
		modelAndView.addObject("result", "중복유저");
		modelAndView.setViewName("/user/registration");
		}
		return modelAndView;
	}
	
	@GetMapping("/newprofile")
	public String newProfileForm() {
		return "user/registration";
	}
	
	@PostMapping("/newprofile")
	public ModelAndView registeruser(@ModelAttribute("user") UserVO user, ModelAndView modelAndView, SessionStatus sessionStatus) {		
		try {
			if(service.isLegitNewUser(user)) {
				log.info("@@@@@@@@"+user);
				service.registerNewUser(user);
				user.setUserPwd(null);
				modelAndView.addObject("user", user);
				modelAndView.setViewName("redirect:/user/welcome"); 
				return modelAndView;
			}
		} catch (DuplicatedUserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			modelAndView.addObject("result", "중복 유저");
			sessionStatus.setComplete();
		} catch (UserMapperFailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			modelAndView.addObject("result", "저장 불가한 유저");
			sessionStatus.setComplete();
		}
		modelAndView.setViewName("redirect:/user/registration");
		return modelAndView;
	}
	
	@GetMapping("/welcome")
	public void welcomePage() {
	}
	
	@GetMapping("/verify")
	public String verify(String key, String userno) {
		try {
			if(service.verifyEmail(userno, key)) {
				service.activateUser(Long.valueOf(userno));
				return "/user/good";
			}
		} catch (NoUserFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/user/fail";
	}
	
	@GetMapping("/list")
	public ModelAndView showList(Model model) {
		ModelAndView modelAndView = new ModelAndView("/user/list");
		try {
			modelAndView.addObject("list", service.getTotalList());
		} catch (NoUserFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("result", "유저가 없어요");
		}
		return modelAndView;
	}
	
	@GetMapping("/deluser")
	public String delUser(Model model, Long userno) {
		try {
			service.deleteUserByNo(userno);
		} catch (NoUserFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("result", "유저가 없어요");
		} catch (UserMapperFailException e) {
			e.printStackTrace();
			model.addAttribute("result", "삭제불가 유저에요");
		}
		return "redirect:/user/list";
	}

	@GetMapping("/profile")
	public void profile(Model model , String userId) {
		try {
			UserVO user = service.getUserById(userId);
			model.addAttribute("user", user);
			model.addAttribute("recipeList", service.getUserRecipeList(user.getUserNo()));
		} catch (NoUserFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("result", "없는 유저");
		}
	}
	
	@GetMapping("/login")
	public void loginPage() {
		
	}
	
	@PostMapping("/login")
	public void login(UserVO user) {
		
	}
	
	@GetMapping("/sendemail")
	public String sendEmail(Model model, String userNo) {
		if(userNo==null) {
			model.addAttribute("result", "잘못된 접근");
			return "/user/welcome"; 
		}
		try {
			service.sendVerificationEmail(service.getUserByNo(Long.valueOf(userNo)));
			model.addAttribute("result", "이멜 전송 완료");
			return "/user/welcome";
		} catch (NoUserFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("result", "잘못된 유저");
			return "/user/welcome";
		}
	}
}
