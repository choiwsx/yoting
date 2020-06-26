package org.kitchen.controller;

import org.kitchen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/recipeBoard/*")
public class UserController_k {

	@Setter(onMethod_ = { @Autowired })
	private UserService Service;

	@GetMapping("/list_k")
	public void list(Model model) {
		model.addAttribute("list_k", Service.getInfobyId());

	}

}
