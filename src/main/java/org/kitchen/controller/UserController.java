package org.kitchen.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.kitchen.domain.Criteria;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;
import org.kitchen.exception.DuplicatedUserException;
import org.kitchen.exception.NoUserFoundException;
import org.kitchen.exception.UserMapperFailException;
import org.kitchen.service.RecipeService;
import org.kitchen.service.SearchService;
import org.kitchen.service.UserService;
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

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")
@SessionAttributes("user")
public class UserController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private SearchService searchService;
	
//	User Account Registration process
	@GetMapping("/registration")
	public void registrationForm() {
	}
	
	@PostMapping("/registration")
	public ModelAndView validateuser(UserVO user) {
		ModelAndView modelAndView = new ModelAndView();
		log.info("#############"+userService.isLegitNewUser(user)+user);		
		if(userService.isLegitNewUser(user)) {
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
			if(userService.isLegitNewUser(user)) {
				log.info("@@@@@@@@"+user);
				userService.registerNewUser(user);
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
			if(userService.verifyEmail(userno, key)) {
				userService.activateUser(Long.valueOf(userno));
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
			modelAndView.addObject("list", userService.getTotalList());
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
			userService.deleteUserByNo(userno);
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
			UserVO user = userService.getUserById(userId);
			model.addAttribute("user", user);
			model.addAttribute("recipeList", userService.getUserRecipeList(user.getUserNo()));
		} catch (NoUserFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("result", "없는 유저");
		}
	}
	
	@GetMapping("/search")
	public String profileSearch(Model model, String userNo, Criteria cri) {
		
		try {
			model.addAttribute("user", userService.getUserByNo(Long.valueOf(userNo)));
		} catch (NumberFormatException | NoUserFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "redirect:/";
		}
		List<RecipeVO> list =searchService.searchUserRecipeList(cri);
		model.addAttribute("recipeList", list);
		model.addAttribute("keyword", cri.getKeyword());
		return "/user/profile";
	}
	
	@GetMapping("/login")
	public void loginPage() {
		
	}
	
	@PostMapping("/login")
	public String login(UserVO user, HttpSession session) {
		UserVO result = userService.tempLogin(user);
		if(result == null) return "/user/login";
		session.setAttribute("userNo", result.getUserNo());
		return "/index";
	}
	
	@GetMapping("/sendemail")
	public String sendEmail(Model model, String userNo) {
		if(userNo==null) {
			model.addAttribute("result", "잘못된 접근");
			return "/user/welcome"; 
		}
		try {
			userService.sendVerificationEmail(userService.getUserByNo(Long.valueOf(userNo)));
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
