package org.kitchen.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.kitchen.domain.ContentVO;

public interface ContentMapper {
	
	public List<ContentVO> getList();
	
	public void insert(ContentVO content);
}
