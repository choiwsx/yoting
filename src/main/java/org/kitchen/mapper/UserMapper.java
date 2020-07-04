package org.kitchen.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kitchen.domain.Criteria;
import org.kitchen.domain.UserVO;
import org.springframework.dao.DataIntegrityViolationException;

public interface UserMapper {
	public void insert(UserVO user) throws DataIntegrityViolationException;
	
	public void insertVeriKey(@Param("userNo") Long userNo, @Param("key") String key);
	public String getVeriKey(Long userNo);
	public int updateVeriKey(@Param("userNo") Long userNo, @Param("key") String key);

	public UserVO selectById(String userId);
	public UserVO selectByEmail(String email);
	public UserVO selectByNo(Long userNo);
	public Long getNoById(String userId);
	
	public boolean idExists(String userId);
	public boolean emailExists(String email);
	
	public boolean isPrivate(String userId);
	
	public int update(UserVO user);
	
	public int delete(UserVO user);
	public int deleteByNo(Long userNo);
	public int deleteById(String userId);
	
	public List<UserVO> getMailingList();
	public List<UserVO> getTotalList();
	
	public List<UserVO> getInfobyId(Criteria cri);
	public List<UserVO> getProfile(String userId); 

}
