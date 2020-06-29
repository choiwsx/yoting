package org.kitchen.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO_w {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria_w cri;
	
	public PageDTO_w(Criteria_w cri, int total)
	{
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		this.startPage = this.endPage - 9;
		
		int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));
		
		if(realEnd<this.endPage)
		{
			this.endPage = realEnd;
		}
		
		
		this.prev = this.startPage > 1;
		
		this.next = this.endPage < realEnd;
		
		
	}
	
}
