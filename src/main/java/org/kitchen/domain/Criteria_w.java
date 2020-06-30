package org.kitchen.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class Criteria_w {
	
	
	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	private String where;
	
	public Criteria_w() {
		this(1,3);
	}
	
	public Criteria_w(int pageNum, int amount)
	{
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
}
