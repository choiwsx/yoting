package org.kitchen.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class RecipeVO {
	private Long rno;
	private Long userNo;
	private int categoryNo;
	private Date regDate;
	private Date updateDate;
	private int cookingTime;
	private String difficulty;
	private String portion;
	private String thumbnail;
	private String title;
	private List<ContentVO> contentList;
}
