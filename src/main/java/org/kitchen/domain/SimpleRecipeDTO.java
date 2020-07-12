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
	
	public SimpleRecipeDTO(RecipeVO recipe, String nickName) {
		setRecipe(recipe);
		this.nickName=nickName;
	}

	public void setRecipe(RecipeVO recipe) {
		this.rno=recipe.getRno();
		this.thumbnail=recipe.getThumbnail();
		this.title=recipe.getTitle();
		this.regDate=recipe.getRegDate();
	}
}
