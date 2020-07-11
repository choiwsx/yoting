package org.kitchen.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RecipeVO {
	private Long rno;
	private Long userNo;
	private int categoryNo;
	private Date regDate;
	private Date updateDate;
	private String cookingTime; // 여기서 int형이면 registration jsp에서 기본값이 0으로 되서 Long을 바꿈
	private String difficulty;
	private String portion;
	private String thumbnail;
	private String title;
	private String reContent; // 지호 수정
	
	private List<ContentVO> contentList;
	
	public RecipeVO() {
		contentList = new ArrayList<>(10);
		int j=1;
		for(int i = 0; i<10; i++)
		{
			ContentVO tmp = new ContentVO();
			tmp.setStepNo(j);
			contentList.add(tmp);
			j++;
		}
	}
}
