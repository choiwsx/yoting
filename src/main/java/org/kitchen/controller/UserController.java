package org.kitchen.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kitchen.domain.Criteria;
import org.kitchen.domain.ProfileDTO;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;
import org.kitchen.exception.DuplicatedUserException;
import org.kitchen.exception.UserMapperFailException;
import org.kitchen.service.SearchService;
import org.kitchen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import lombok.extern.log4j.Log4j;
import net.sf.json.JSONArray;

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
	public String registrationForm(Model model, HttpSession session) {
		if( session.getAttribute("userNo")!=null ) {
			return wrongAccess(model);
		}
		return "/user/registration";
	}
	
	@PostMapping("/registration")
	public String validateuser(UserVO user, Model model, HttpSession session) {
		if( session.getAttribute("userNo")!=null ) {
			return wrongAccess(model);
		}
		log.info("#############"+userService.isLegitNewUser(user)+user);		
		if(userService.isLegitNewUser(user)) {
			model.addAttribute("user", user);
			return "/user/newprofile";
		} else {
			model.addAttribute("result", "중복된 유저 아이디 혹은 이메일입니다.");
		}
		return "/user/registration";
	}
	
	@GetMapping("/newprofile")
	public String newProfileForm(Model model, HttpSession session) {
		if( session.getAttribute("userNo")!=null ) {
			return wrongAccess(model);
		}
		return "redirect:/user/registration";
	}
	
	@PostMapping("/newprofile")
	public String registeruser(@ModelAttribute("user") UserVO user, Model model, SessionStatus sessionStatus, HttpSession session) {
		if( session.getAttribute("userNo")!=null ) {
			return wrongAccess(model);
		}	
		try {
			if(userService.isLegitNewUser(user)) {
				log.info("@@@@@@@@"+user);
				userService.registerNewUser(user);
				user.setUserPwd(null);
				model.addAttribute("user", user);
				return "redirect:/user/welcome";
			}
		} catch (DuplicatedUserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("result", "중복 유저");
			sessionStatus.setComplete();
		} catch (UserMapperFailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("result", "저장 불가한 유저");
			sessionStatus.setComplete();
		}
		return "/error";

	}
	
	@GetMapping("/welcome")
	public void welcomePage(SessionStatus sessionStatus) {
		sessionStatus.setComplete();
	}
	
	@GetMapping("/verify")
	public String verify(String key, String userno, Model model) {
		if(userService.verifyEmail(userno, key)) {
			userService.activateUser(Long.valueOf(userno));
			model.addAttribute("result", "인증되었습니다.");
			return "redirect:/good";
		}		
		model.addAttribute("result", "인증 실패. 잘못된 인증 링크입니다.");
		return "redirect:/error";
	}
	
	@GetMapping("/list")
	public void showList(Model model) {
		model.addAttribute("list", userService.getTotalList());
	}
	
	@GetMapping("/deluser")
	public String delUser(Model model, String userNo) {
		try {
			userService.deleteUserByNo(Long.valueOf(userNo));
		} catch (UserMapperFailException e) {
			e.printStackTrace();
			model.addAttribute("result", "삭제불가 유저에요");
			return "redirect:/error";
		} catch (NumberFormatException e) {
			return wrongAccess(model);
		}
		return "redirect:/user/list";
	}

	@GetMapping("/profile")
	public String profile(Model model , String userId, HttpSession session) {
		log.info("get@@@@@@@@@@@@@@@");
		UserVO user = userService.getUserById(userId);
		if(user==null) {
			model.addAttribute("result", "없는 유저입니다.");
			return "redirect:/error";
		}
		model.addAttribute("user", user);
		model.addAttribute("recipeList", userService.getUserRecipeList(user.getUserNo()));
		ProfileDTO profile = new ProfileDTO(user, userService.getUserRecipeList(user.getUserNo()));
		profile.setFollowers(userService.countFollower(user.getUserNo()));
		if(session.getAttribute("userNo")!=null) {
			Long followerNo = (Long)session.getAttribute("userNo");
			profile.setFollowing(userService.countFollower(user.getUserNo(), followerNo)==1);
		}
		model.addAttribute("profile",profile);
		return "/user/profile";
	}
	
	@GetMapping("/mkitchen")
	public String mkitchen(Model model, HttpSession session) {
		if(session.getAttribute("userNo")==null)
		{
			return wrongAccess(model);
		}
//		String userNoString = String.valueOf(session.getAttribute("userNo"));
//		Long userNo = Long.valueOf(userNoString);
		Long userNo = (Long)session.getAttribute("userNo");
		UserVO user = userService.getUserByNo(userNo);
		if(user==null)
		{
			model.addAttribute("result", "잘못된 접근입니다.");
			return "redirect:/error";			
		}
		model.addAttribute("user", user);
		model.addAttribute("recipeList", userService.getUserRecipeList(user.getUserNo()));
		log.info("@@@@user@@@@"+user);
		return "/user/mkitchen";
	}
	@GetMapping("/testprofile")
	public String testprofile(Model model, HttpSession session) {
		if(session.getAttribute("userNo")==null)
		{
			return wrongAccess(model);
		}
//		String userNoString = String.valueOf(session.getAttribute("userNo"));
//		Long userNo = Long.valueOf(userNoString);
		Long userNo = (Long)session.getAttribute("userNo");
		UserVO user = userService.getUserByNo(userNo);
		if(user==null)
		{
			model.addAttribute("result", "잘못된 접근입니다.");
			return "redirect:/error";			
		}
		model.addAttribute("user", user);
		model.addAttribute("recipeList", userService.getUserRecipeList(user.getUserNo()));
		log.info("@@@@user@@@@"+user);
		return "/user/testprofile";
	}
	
	@GetMapping("/search")
	public String profileSearch(Model model, String userNo, Criteria cri) {
		
		try {
			model.addAttribute("user", userService.getUserByNo(Long.valueOf(userNo)));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("result", "잘못된 접근입니다.");
			return "redirect:/error";
		}
		List<RecipeVO> list =searchService.searchUserRecipeList(cri);
		model.addAttribute("recipeList", list);
		model.addAttribute("keyword", cri.getKeyword());
		return "redirect:/user/profile";
	}
	
	@GetMapping("/login")
	public String loginPage(HttpSession session, Model model) {
		if(session.getAttribute("userNo")!=null) {
			return "/";
		}
		return "/user/login";
	}
	
	@PostMapping("/login")
	public String login(Model model, UserVO user, HttpSession session) {
		UserVO result = userService.tempLogin(user);
		if(result == null) {
			model.addAttribute("result", "아이디와 비밀번호가 맞지않습니다.");
			return "/user/login";
		}
		session.setAttribute("userNo", result.getUserNo());
		return "/index";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session, Model model) {
		if(session.getAttribute("userNo")==null) {
			model.addAttribute("result", "로그인도 안해놓고 로그아웃?");
			return "redirect:/error";
		}
		session.removeAttribute("userNo");
		model.addAttribute("result", "로그아웃 성공");
		return "redirect:/good";
	}
	
	@GetMapping("/resendEmail")
	public void resendEmail() {
		
	}
	
	@PostMapping("/sendEmail")
	public String sendEmail(Model model, String email) {
		if(email==null) {
			model.addAttribute("result", "이메일 주소가 잘못됐습니다.");
			return "redirect:/error"; 
		}
		UserVO user = userService.getUserByEmail(email);
		if(user==null) {
			model.addAttribute("result", "이메일 주소로 등록된 사용자가 없습니다.");
			return "redirect:/error"; 
		}
		userService.sendVerificationEmail(user);
		model.addAttribute("result", "이멜 전송 완료, 메일함을 확인해주세요.");
		return "redirect:/good";
	}
	@RequestMapping(value = "/user/autocomplete", method = RequestMethod.POST)
	public void AutoTest(Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse resp,UserVO user) throws IOException {
		
		String result = request.getParameter("term");
	
		List<UserVO> list = userService.getIdAutocomplete(result); //result값이 포함되어 있는 emp테이블의 네임을 리턴

		JSONArray ja = new JSONArray();
		for (int i = 0; i < list.size(); i++) {
			ja.add(list.get(i).getUserId());
		}
		PrintWriter out = resp.getWriter();

		out.print(ja.toString());
	}
	
	@PostMapping("/follow")
	public String follow(Long followeeNo, Long followerNo, Model model) {
		log.info("follow########"+followeeNo+"@@@@@"+followerNo);
		if(userService.follow(followeeNo, followerNo)) {
		model.addAttribute("result", "팔로우 완료.");
		return "redirect:/user/profile?userId="+userService.getUserByNo(followeeNo).getUserId();
		} 
		return wrongAccess(model, "팔로우 실패");
	}
	
	@PostMapping("/unfollow")
	public String unfollow(Long followeeNo, Long followerNo, Model model) {
		log.info("unfollow########"+followeeNo+"@@@@@"+followerNo);
		if(userService.unfollow(followeeNo, followerNo)) {
			model.addAttribute("result", "언팔로우 완료.");
			return "redirect:/user/profile?userId="+userService.getUserByNo(followeeNo).getUserId();
		}
		return wrongAccess(model, "언팔로우 실패");
	}
	
	private String wrongAccess(Model model) {
		// TODO Auto-generated method stub
		model.addAttribute("result", "잘못된 접근입니다.");
		return "/error";
	}
	
	private String wrongAccess(Model model, String string) {
		// TODO Auto-generated method stub
		model.addAttribute("result", string);
		return "/error";
	}
}
