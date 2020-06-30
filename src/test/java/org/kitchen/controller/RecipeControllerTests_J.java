package org.kitchen.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)

@WebAppConfiguration
@ContextConfiguration
({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@Log4j
public class RecipeControllerTests_J {
	
	@Setter(onMethod_ = { @Autowired })
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
//	@Test
	public void testList() throws Exception
	{
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/recipe/list"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	@Test
	public void testRegister() throws Exception
	{
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/recipe/register")
				.param("cookingTime", "30")
				.param("difficulty", "1")
				.param("userNo", "3")
				.param("thumbnail", "간장계란밥사진")
				.param("title", "간장계란밥 만들기~!~~~")
				.param("categoryNo", "44")
				/*
				.param("stepNo", "1")
				.param("title", "하이")
				.param("stepNo", "2" )
				.param("title", "두번째 제목") */
				).andReturn().getModelAndView().addObject(attributeValue).getViewName();
		
		log.info(resultPage);
	}
	
//	@Test
	public void testGet() throws Exception
	{
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/recipe/get")
				.param("rno", "41"))
				.andReturn()
				.getModelAndView().getModelMap());
	}
	
}
