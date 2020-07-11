package org.kitchen.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kitchen.domain.Criteria;
import org.kitchen.domain.ProfileDTOFactory;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;
import org.kitchen.enums.UserStatus;
import org.kitchen.exception.DuplicatedUserException;
import org.kitchen.exception.UserMapperFailException;
import org.kitchen.service.SearchService;
import org.kitchen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
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
   
//   User Account Registration process
   @GetMapping("/registration")
   public String registrationForm(Model model, HttpSession session) {
      //로그인 상태면 가입 막기
      if( session.getAttribute("userNo")!=null ) {
         return wrongAccess(model);
      }
      return "/user/registration";
   }
   
   @PostMapping("/registration")
   public String validateuser(UserVO user, Model model, HttpSession session) {
      //로그인 상태면 가입 막기
      if( session.getAttribute("userNo")!=null ) {
         return wrongAccess(model);
      }
      log.info("#############"+userService.isLegitNewUser(user)+user);
      //아이디, 이메일 중복 확인
      String message = "";
      if(!userService.isLegitUserId(user.getUserId())) {
         message += "중복된 아이디입니다.\n";
      }
      if(!userService.isLegitUserEmail(user.getEmail())) {
         message += " 중복된 이메일입니다.\n";
      }
      if(!message.equals("")) {
         model.addAttribute("user", user);
         model.addAttribute("result", message);
      } else {
         //중복 아니면 그 다음 단계로 이동
         model.addAttribute("user", user);
         return "/user/newprofile";
      }
      return "/user/registration";
   }
   
   @GetMapping("/newprofile")
   public String newProfileForm(Model model, HttpSession session) {
      //로그인 상태면 가입 막기
      if( session.getAttribute("userNo")!=null ) {
         return wrongAccess(model);
      }
      //가입 화면에서 유저 아이디, 비번등 없으면 뉴 프로필 화면 주지않음.
      if(session.getAttribute("user")==null) {
         return wrongAccess(model);
      }
      return "redirect:/user/registration";
   }
   
   @PostMapping("/newprofile")
   public String registeruser(@ModelAttribute("user") UserVO user, Model model, SessionStatus sessionStatus, HttpSession session) {
      //로그인 상태면 가입 막기
      if( session.getAttribute("userNo")!=null ) {
         return wrongAccess(model);
      }
      //아이디,이멜 중복 확인 한번 더
      try {
         if(userService.isLegitNewUser(user)) {
            //중복 아니면 가입시키기
            userService.registerNewUser(user);
            //@@가입축하 붙여서 엠키친보내기????????????
            user.setUserPwd(null);
            model.addAttribute("user", user);
            return "redirect:/user/welcome";
         }
      } catch (DuplicatedUserException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
         sessionStatus.setComplete();
         return wrongAccess(model, "중복된 유저 가입 시도");
      } catch (UserMapperFailException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
         sessionStatus.setComplete();
         return wrongAccess(model, "유저 저장 실패, 다시 시도해주세요.");
      }
      return wrongAccess(model, "중복된 유저 가입 시도");
   }
   
   @GetMapping("/welcome")
   public String welcomePage(HttpSession session, SessionStatus sessionStatus, Model model) {
      //로그인 상태면 가입 막기
      if(session.getAttribute("user")==null) {
         return wrongAccess(model);
      }
      sessionStatus.setComplete();
      return "/user/welcome";
   }
   
   @GetMapping("/verify")
   public String verify(String key, String userno, Model model) {
      //유저 넘버 잘못됐으면 . 공백||널||숫자 체크
      if(userno.equals("") || userno==null || !isNumeric(userno)) {
         return wrongAccess(model);
      }
      Long userNo = Long.parseLong(userno);
      if(userService.verifyEmail(userNo, key)) {
         userService.activateUser(userNo);
         //엠키친으로이동?@@@@
         model.addAttribute("result", "인증되었습니다.");
         return "redirect:/good";
      }      
      return wrongAccess(model, "이메일 인증 실패. 잘못된 인증 링크입니다.");
   }
   
//   @GetMapping("/list")
//   public void showList(Model model) {
//      model.addAttribute("list", userService.getTotalList());
//   }
   
//   @GetMapping("/deluser")
//   public String delUser(Model model, String userNo) {
//      try {
//         userService.deleteUserByNo(Long.valueOf(userNo));
//      } catch (UserMapperFailException e) {
//         e.printStackTrace();
//         model.addAttribute("result", "삭제 불가 유저에요");
//         return "redirect:/error";
//      } catch (NumberFormatException e) {
//         return wrongAccess(model);
//      }
//      return "redirect:/user/list";
//   }

   @GetMapping("/profile")
   public String profile(Model model , String userId, HttpSession session) {      
      log.info("get@@@@@@@@@@@@@@@");
      //유저 아이디 유효성 검사
      UserVO user = userService.getUserById(userId);
      if(user==null) {
         return wrongAccess(model, "없는 유저입니다.");
      }
      //로그인한 유저 체크
      Long userNo = (Long)session.getAttribute("userNo");
      log.info("@@@@@@@@@@@@@@@"+userNo+"@"+user.getUserNo()+"@");
      if(userNo!=null) {
         //로그인 중이면
         if(userNo.equals(user.getUserNo())) {
            //로그인 중인데 가려는 페이지가 자기 페이지이면
            log.info("자기페이지");
            return "redirect:/user/mkitchen";
         }
         model.addAttribute("profile", ProfileDTOFactory.getProfile(user, userNo));
      } else {
         //로그인 중이지 않으면
         model.addAttribute("profile", ProfileDTOFactory.getProfile(user));
      }
      return "/user/profile";
   }
   
   @GetMapping("/mkitchen")
   public String mkitchen(Model model, HttpSession session) {
      //로그인 중이 아니면 마이키친 막기
      if(session.getAttribute("userNo")==null)
      {
         return wrongAccess(model);
      }
//      String userNoString = String.valueOf(session.getAttribute("userNo"));
//      Long userNo = Long.valueOf(userNoString);
      //로그인 유저넘버 유효성 확인
      Long userNo = (Long)session.getAttribute("userNo");
      UserVO user = userService.getUserByNo(userNo);
      if(user==null)
      {
         return wrongAccess(model);      
      }
      //유저와 레시피주기
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
//      String userNoString = String.valueOf(session.getAttribute("userNo"));
//      Long userNo = Long.valueOf(userNoString);
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
      //유저 넘버 잘못됐으면 . 공백||널||숫자 체크
      if(userNo.equals("") || userNo==null || !isNumeric(userNo)) {
         return wrongAccess(model);
      }
      model.addAttribute("user", userService.getUserByNo(Long.valueOf(userNo)));
      List<RecipeVO> list =searchService.searchUserRecipeList(cri);
      model.addAttribute("recipeList", list);
      model.addAttribute("keyword", cri.getKeyword());
      return "redirect:/user/profile";
   }
   
   @GetMapping("/login")
   public String loginPage(HttpSession session, Model model) {
      //로그인중이면 메인페이지로
      if(session.getAttribute("userNo")!=null) {
         return "redirect:/";
      }
      return "/user/login";
   }
   
   @PostMapping("/login")
   public String login(Model model, UserVO user, HttpSession session) {
      //로그인중이면 메인페이지로
      if(session.getAttribute("userNo")!=null) {
         return "redirect:/";
      }
      //로그인 확인
      UserVO result = userService.tempLogin(user);
      if(result == null) {
         model.addAttribute("result", "아이디와 비밀번호가 맞지않습니다.");
         return "/user/login";
      }
      //회원 상태 확인
      if(result.getStatus().equals(UserStatus.ACTIVE)) {
         //유효 회원이면
         session.setAttribute("userNo", result.getUserNo());
         return "redirect:/";
      } else if(result.getStatus().equals(UserStatus.PENDING)) {
         //이메일 인증 기다리는 회원이면
         return wrongAccess(model, "이메일 인증을 해주세요.");
      } else {
         return wrongAccess(model, "유효하지 않은 유저입니다.");

      }
   }
   
   @GetMapping("/logout")
   public String logout(HttpSession session, Model model) {
      //로그인 체크
      if(session.getAttribute("userNo")==null) {
         return wrongAccess(model, "로그인 상태가 아닙니다.");
      }
      session.removeAttribute("userNo");
      model.addAttribute("result", "로그아웃 성공");
      return "redirect:/";
   }
   
   @GetMapping("/resendEmail")
   public String resendEmail(HttpSession session, Model model) {
      //로그인 상태면 인증 메일 보내는 페이지 막기
      if( session.getAttribute("userNo")!=null ) {
         return wrongAccess(model);
      }
      return "/user/resendEmail";
   }
   
   @PostMapping("/resendEmail")
   public String resendEmail(Model model, String email) {
      //이메일 주소 유효성 검사
      if(email.equals("")||email==null) {
         return wrongAccess(model, "이메일 주소가 잘못입력되었습니다.");
      }
      //이메일이 등록된 회원것인지 검사
      UserVO user = userService.getUserByEmail(email);
      if(user==null) {
         return wrongAccess(model, "이메일 주소로 등록된 사용자가 없습니다.");
      }
      //이메일 인증을 기다리는 회원인지 검사
      if(user.getStatus().equals(UserStatus.PENDING)) {
      userService.sendVerificationEmail(user);
      model.addAttribute("result", "인증 메일 전송 완료, 메일함을 확인해주세요.");
      return "redirect:/";
      } else if(user.getStatus().equals(UserStatus.ACTIVE)) {
         return wrongAccess(model, "이미 인증을 마친 회원입니다.");
      }
      return wrongAccess(model, "유효하지 않은 회원입니다.");
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
   
   @GetMapping("/follow")
   public String follow(Model model) {
      //겟 막기
      return wrongAccess(model);
   }
   
   @PostMapping("/follow")
   public String follow(Long followeeNo, Long followerNo, Model model) {
      //유효성 체크
      if(!userService.isValidUser(followerNo) || !userService.isValidUser(followeeNo)) {
         return wrongAccess(model, "유효하지 않은 유저 팔로우");
      }
      log.info("follow########"+followeeNo+"@@@@@"+followerNo);
      if(userService.follow(followeeNo, followerNo)) {
      return "redirect:/user/profile?userId="+userService.getUserByNo(followeeNo).getUserId();
      } 
      return wrongAccess(model, "팔로우 실패");
   }
   
   @GetMapping("/unfollow")
   public String unfollow(Model model) {
      //겟 막기
      return wrongAccess(model);
   }
   
   @PostMapping("/unfollow")
   public String unfollow(Long followeeNo, Long followerNo, Model model) {
      //유효성 체크
      if(!userService.isValidUser(followerNo) || !userService.isValidUser(followeeNo)) {
         return wrongAccess(model, "유효하지 않은 유저 팔로우");
      }
      log.info("unfollow########"+followeeNo+"@@@@@"+followerNo);
      if(userService.unfollow(followeeNo, followerNo)) {
         return "redirect:/user/profile?userId="+userService.getUserByNo(followeeNo).getUserId();
      }
      return wrongAccess(model, "언팔로우 실패");
   }
   
   @GetMapping("/hotkitchen")
   public void rank(Model model) {
      model.addAttribute("list", searchService.getHotUserList(10));
      
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
   
   private boolean isNumeric(String no) {
      try {
           double d = Double.parseDouble(no);
       } catch (NumberFormatException nfe) {
           return false;
       }
      return true;
   }
}