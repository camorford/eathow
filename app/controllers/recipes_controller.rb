class RecipesController < ApplicationController

	def new
		@recipe = Recipe.new
	end

	def recipe_params
  		params.require(:recipe).permit(:name,:directions,:carbs,:protein,)
  	end

end