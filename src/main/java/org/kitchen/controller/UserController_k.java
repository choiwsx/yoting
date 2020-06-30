package org.kitchen.controller;

import org.kitchen.domain.Criteria_k;
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
@RequestMapping("/userBoard/*")
public class UserController_k {

	@Setter(onMethod_ = { @Autowired })
	private UserService Service;

	@GetMapping("/userSearch")
	public void list(Criteria_k cri, Model model) {
		model.addAttribute("userSearch", Service.getInfobyId(cri));

	}

	@GetMapping("/profile")
	public void profile(Model model , String userId) {
		model.addAttribute("profile", Service.getProfile(userId));

	}
}
