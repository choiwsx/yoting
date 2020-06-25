package org.kitchen.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.kitchen.domain.ContentVO;

public interface ContentMapper {
	
	public List<ContentVO> getList();
	
	public void insert(ContentVO content);
	
//	public void insertSelectKey(ContentVO content);
	
	public List<ContentVO> read(Long rno);
	
	public int delete(Long rno);
	
	public int update(ContentVO content);
	
}
