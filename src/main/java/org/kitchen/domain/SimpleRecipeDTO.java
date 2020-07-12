package org.kitchen.domain;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SimpleRecipeDTO {
	Long rno;
	String thumbnail;
	String title;
	String nickName;
	Date regDate;

}
