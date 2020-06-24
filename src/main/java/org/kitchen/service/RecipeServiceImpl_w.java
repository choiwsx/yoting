package org.kitchen.service;

import org.kitchen.mapper.RecipeMapper_w;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class RecipeServiceImpl_w {
	
	@Setter(onMethod_ = @Autowired)
	private RecipeMapper_w mapper;


}
