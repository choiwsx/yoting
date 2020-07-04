package org.kitchen.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kitchen.domain.ContentVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ContentMapperTests {
	
	private static final Logger log = LoggerFactory.getLogger(ContentMapperTests.class);

	@Autowired
	private ContentMapper mapper;
	
//	@Test
	public void testGetList()
	{
		mapper.getList().forEach(content -> log.info(content.toString()));
	}
	
//	@Test
	public void testInsert()
	{
		ContentVO content = new ContentVO();
		
		content.setStepNo(1);
		content.setRno(41L);
		content.setPhotoUrl("https://www.mediafine.co.kr/news/photo/201608/4153_8093_3852.jpg");
		content.setContent("�����佺�� �Ľ�Ÿ step1");
		
		mapper.insert(content);
		
		log.info(content.getPhotoUrl());
	}
	
//	@Test
	public void testRead()
	{
		List<ContentVO> content = mapper.read(3L);
		
		log.info(content.toString());
	}
	
//	@Test
	public void testDelete()
	{
		log.info("DELETE COUNT : " + mapper.delete(41L));
	}
	
	@Test
	public void testUpdate()
	{
		List<ContentVO> contentList = mapper.read(41L);
		int step = 1;
		ContentVO content = contentList.get(step-1);
		
//		log.info("��ȣ : " +content.getStepNo());
		
		content.setRno(content.getRno());
		content.setStepNo(content.getStepNo());
		content.setContent("�����佺�� �Ľ�Ÿ step1 ����22");
		content.setPhotoUrl("����22");
		
		log.info(content.toString());
		
		int count = mapper.update(content);
		log.info("UPDATE COUNT : " + count);
	}
}
