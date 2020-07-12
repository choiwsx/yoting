package org.kitchen.domain;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SimpleRecipeDTO {
	private Long rno;
	private String thumbnail;
	private String title;
	private String nickName;
	private int categoryNo;
	private Date regDate;
	
	public SimpleRecipeDTO(RecipeVO recipe, String nickName) {
		setRecipe(recipe);
		this.nickName=nickName;
	}

	public void setRecipe(RecipeVO recipe) {
		this.rno=recipe.getRno();
		this.thumbnail=recipe.getThumbnail();
		this.title=recipe.getTitle();
		this.regDate=recipe.getRegDate();
		this.categoryNo=recipe.getCategoryNo();
	}
}
