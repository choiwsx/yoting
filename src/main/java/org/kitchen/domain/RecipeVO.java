package org.kitchen.domain;

import java.util.Date;

import lombok.Data;

@Data
public class RecipeVO {
	private Long rno;
	private String title;
	private String thumbnail;
	private Date regdate;
	private Date updateDate;
	private int cookingTime;
	private String difficulty;
	private Long userNo;
//	private ContentVO[] contents;
//	private String[] material;
//	private long[] reviewRecipes;
	private int categoryNo;
	
}
