class RecipesController < ApplicationController

	def index
		@recipes = Recipe.macros(current_user.macros)
		@favorite = Favorite.where(user_id: current_user.id)
	end

	def edit
    	@recipe = Recipe.find(params[:id])
  	end

	def show
    	@recipe = Recipe.find(params[:id])
    	@favorite = Favorite.new
  	end

	def new
		@recipe = Recipe.new
		@recipe.ingredients.build
	end

	def create
		@recipe = Recipe.new(recipe_params)
		if @recipe.save
  		redirect_to @recipe
  	else
  		render 'new'
  	end
  end

    def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      flash[:success] = "Profile updated"
      redirect_to @recipe
    else
      render 'edit'
    end
  end

	private

	def recipe_params
  	params.require(:recipe).permit(:name,:directions,:calories,:carbs,:fat,:protein,ingredients_attributes:[:id,:name,:destroy])
  end

end