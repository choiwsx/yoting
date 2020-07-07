package org.kitchen.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Setter
@Getter
public class ContentVO {
	private int stepNo;
	private Long rno;
	private String photoUrl;
	private String content;
	
}
