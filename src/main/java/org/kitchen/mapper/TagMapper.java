package org.kitchen.mapper;


public interface TagMapper {
	
	public void insert(String tagName);
	
	public int deleteByName(String tagName);
	
	public int deleteByNo(Long tagNo);
	
	public int selectByName(String tagName);
	
	public int selectByNo(Long tagNo);

}
