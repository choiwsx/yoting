package org.kitchen.mapper;

import java.util.List;


public interface TagMapper {
	
	public void insert(String tagName);
	
	public int deleteByName(String tagName);
	
	public int deleteByNo(Long tagNo);
	
	public Long selectByName(String tagName);
	
	public String selectByNo(Long tagNo);

}
