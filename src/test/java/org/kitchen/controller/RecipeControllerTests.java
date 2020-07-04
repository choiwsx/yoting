package org.kitchen.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kitchen.mapper.CategoryMapperTests;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
public class RecipeControllerTests {
	
	private static final Logger log = LoggerFactory.getLogger(RecipeControllerTests.class);

	@Autowired
	private WebApplicationContext ctx;

	private MockMvc mockMvc;

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}

	@Test
	public void testList() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/recipe/list")).andReturn().getModelAndView()
				.getModelMap().toString());
	}

	@Test
	public void testListPaging() throws Exception {
		log.info(mockMvc
				.perform(MockMvcRequestBuilders.get("/search/searchresult").param("pageNum", "2").param("amount", "3"))
				.andReturn().getModelAndView().getModelMap().toString());
	}

	@Test
	public void testList2() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/recipe/list")).andReturn().getModelAndView()
				.getModelMap().toString());
	}

	// @Test
	public void testRegister() throws Exception {
	}

	@Test
	public void testGet() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/recipe/get").param("rno", "41")).andReturn()
				.getModelAndView().getModelMap().toString());
	}
}
