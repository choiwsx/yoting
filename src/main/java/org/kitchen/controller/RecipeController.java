package org.kitchen.controller;

import javax.servlet.http.HttpSession;

import org.kitchen.domain.RecipeVO;
import org.kitchen.domain.UserVO;
import org.kitchen.service.RecipeService;
import org.kitchen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

	@PostMapping("/registration")
	public String register(RecipeVO recipe, RedirectAttributes rttr) {
		recipeService.register(recipe);
		rttr.addFlashAttribute("result", recipe.getRno());
		return "redirect:/user/mkitchen";
	}

	@GetMapping("/registration")
	public String registerform(Model model, HttpSession session) {
		// 입력 폼에 레시피 VO만들어서 주기
		if ((Long) session.getAttribute("userNo") == null) {
			return wrongAccess(model, "로그인이 필요한 페이지 입니다.");
		}
		Long userNo = (Long) session.getAttribute("userNo");
		UserVO user = userService.getUserByNo(userNo);
		if (user == null) {
			return wrongAccess(model, "로그인이 필요한 페이지 입니다.");
		}else
		model.addAttribute("recipe", new RecipeVO());

		return "/recipe/registration";
	}

	@GetMapping("/result")
	public String result(Model model) {
		// 등록 결과를 겟하려하면 오류주기
		return wrongAccess(model);
	}

	@PostMapping("/result")
	public @ModelAttribute("recipe") RecipeVO register2save(@ModelAttribute("recipe") RecipeVO recipe) {
		// 레시피 등록하러 오면 recipeService에 저장하기
		recipeService.register(recipe);
		return recipe;
	}

//   @GetMapping("/get")
//   public void get(Long rno, Model model) {
//      log.info("/get");
//      model.addAttribute("recipe", recipeService.get(rno));
//      model.addAttribute("content", recipeService.getCon(rno));
//   }

//   //일단 포스트있어서 겟막기
//   @GetMapping("/modify")
//   public String modify(Model model) {
//      return wrongAccess(model);
//   }
//   
//   @PostMapping("/modify")
//   public String modify(RecipeVO recipe, ContentVO content, RedirectAttributes rttr) {
//      log.info("modify: " + recipe);
//      log.info("modify: " + content);
//
//      if (recipeService.modify(recipe)) {
//         rttr.addFlashAttribute("result", "success");
//      }
//      return "redirect:/recipe/detail?rno"+recipe.getRno();
//   }

	@GetMapping("/modiRecipe")
	public String modiRecipe(Model model, String rno, HttpSession session) {
		//게시글 넘버 잘못됐으면 . 공백||널||숫자 체크
		if(rno==null  || rno.equals("") || !isNumeric(rno)) {
			return wrongAccess(model);
		}
		try {
			Long checkUserNo = recipeService.isMyRecipe(Long.valueOf(rno));
			if (session.getAttribute("userNo") == null
					|| (!(((Long) session.getAttribute("userNo")).equals(checkUserNo)))) {
				return wrongAccess(model);
			}
		} catch (NumberFormatException e) {
			return wrongAccess(model);
		}

		try {
			RecipeVO recipe = recipeService.get(Long.valueOf(rno));
			if (recipe == null) {
				model.addAttribute("result", "수정할 레시피가 없어요");
				// @@@엠키친 리턴?
				return "/error";
			}
			log.info("@@@get Rno@@@@" + recipe.getRno());
			model.addAttribute("recipe", recipe);
			return "/recipe/modiRecipe";
		} catch (NumberFormatException e) {
			return wrongAccess(model);
		}
	}

	@PostMapping("/modiRecipe")
	public String modiRecipe(Model model, RecipeVO recipe, HttpSession session) {
		log.info("!!recipe!!!" + recipe.getRno());
		Long userNo = recipe.getUserNo();
		if (session.getAttribute("userNo") == null || (!(((Long) session.getAttribute("userNo")).equals(userNo)))) {
			return wrongAccess(model);
		}
		if (recipe == null)
			return wrongAccess(model);
		if (recipeService.get(recipe.getRno()) == null) {
			model.addAttribute("result", "수정할 레시피가 없어요");
			return "/error";
		}
		recipeService.modify(recipe);
		return "redirect:/recipe/detail?rno=" + recipe.getRno();
	}

	@GetMapping("/list")
	public String list(String categoryNo, Model model) {
		//카테고리 없으면 그냥 전체 리스트
		if( categoryNo==null ) {
			model.addAttribute("list", recipeService.getList());
		} else {
			//카테고리 넘버 공백||숫자 유효성 체크
			if(categoryNo.equals("") || !isNumeric(categoryNo)) {
				return wrongAccess(model);
			}
			//카테고리 있으면 카테고리 리스트
			Long categoryNoLong = Long.parseLong(categoryNo);
			model.addAttribute("category",recipeService.getCategoryNamebyPrevCode(categoryNoLong));
			model.addAttribute("list",recipeService.getCategoryCode(categoryNoLong));
		}
		model.addAttribute("tag",recipeService.getTagNameList());		
		return "/recipe/list";
	}

	@GetMapping("detail")
	public String detail(Model model, String rno, HttpSession session) {
		// 게시글 넘버 잘못됐으면 . 공백||널||숫자 체크
		if (rno.equals("") || rno == null || !isNumeric(rno)) {
			return wrongAccess(model);
		}
		Long rnoLong = Long.parseLong(rno);
		RecipeVO recipe = recipeService.get(rnoLong);
		model.addAttribute("tag", recipeService.getTagNameList());
		model.addAttribute("author", userService.getUserByNo(recipe.getUserNo()));
		model.addAttribute("recipe", recipe);
		model.addAttribute("contentList", recipeService.getCon(rnoLong));
		Long loginUno = (Long) session.getAttribute("userNo");
		if (recipe.getUserNo().equals(loginUno)) {
			model.addAttribute("canModify", "true");
		}
		return "/recipe/detail";
	}

	@GetMapping("del")
	public String delelete(Model model, @RequestParam("rno") String rno) {
		// 게시글 넘버 잘못됐으면 . 공백||널||숫자 체크
		if (rno.equals("") || rno == null || !isNumeric(rno)) {
			return wrongAccess(model);
		}
		Long rnoLong = Long.parseLong(rno);
		log.info("@@@@@rrrrrrrrnnnnnnnnnnooooooooo@@@@" + rno);
		if (recipeService.remove(rnoLong)) {
			// model.addAttribute("result", "success");
		} else {
			// model.addAttribute("result", "fail");
		}
//      String referer = request.getHeader("Referer");
		return "redirect:/user/mkitchen";
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

//   @GetMapping("/category")
//   public void list(Long categoryNo, Model model) {
//      if (categoryNo == null) {
//         model.addAttribute("list", recipeService.getList());
//      } else {
//         model.addAttribute("list", recipeService.getCategoryCode(categoryNo));
//      }
//   }

}