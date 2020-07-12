package org.kitchen.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kitchen.domain.Criteria;
import org.kitchen.domain.PageDTO;
import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;
import org.kitchen.service.RecipeService;
import org.kitchen.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.sf.json.JSONArray;


/**
 * Handles requests for the application home page.
 */
//지호: null값 유효성체크 0711
@Controller
public class HomeController {

   private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
   
   @Autowired
   private RecipeService recipeService;
   @Autowired
   private UserService userService;


   /**
    * Simply selects the home view to render by returning its name.
    */
   @RequestMapping(value = "/", method = RequestMethod.GET)
   public String home(Locale locale, Model model, Criteria cri) {
      logger.info("Welcome home! The client locale is {}.", locale);
      logger.info("YO! Welcome home! The client locale is {}.", locale);
      //Date date = new Date();
      //DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
      //String formattedDate = dateFormat.format(date);
      RecipeVO latestRecipe = recipeService.getLatestRecipe();
      
      UserVO author = userService.getUserByNo(latestRecipe.getUserNo());
      model.addAttribute("latestRecipe", latestRecipe);
      model.addAttribute("author", author);
//      model.addAttribute("tag",recipeService.getTagNameList());
//      model.addAttribute("pageMaker", new PageDTO(cri, 100));
//      model.addAttribute("list", recipeService.getList());
      model.addAttribute("list", recipeService.getList().subList(0, 12));

      return "index";
   }
   
   @GetMapping("/good")
   public void getGood() {
      
   }

   @PostMapping("/good")
   public void postGood() {
      
   }
   
   @GetMapping("/error")
   public void getError() {
      
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
		
	@RequestMapping(value = "/autocomplete", method = RequestMethod.POST)
	public void AutoTest(Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse resp,UserVO user) throws IOException {
	
		String result = request.getParameter("term");
		
			List<UserVO> list = userService.getIdAutocomplete(result); //result값이 포함되어 있는 emp테이블의 네임을 리턴
			JSONArray ja = new JSONArray();
			for (int i = 0; i < list.size(); i++) {
				ja.add(list.get(i).getUserId());
			}
	} 
}

