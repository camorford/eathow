class FavoritesController < ApplicationController
	 def index
	 	@favorites = current_user.favorite_recipes
	 end

	 def show
    	@recipe = Favorite.find(params[:id]).recipe
 	 end

	 def create
	  	# if Favorite.create(favorited: @recipe, user: current_user, name: params['favorite']['name']) 
	  	# 	redirect_to recipes_path, notice: 'Recipe has been favorited'
	  	# else
	  	# 	redirect_to recipes_path, alert: 'Something went wrong..'
	  	# end
		  @favorite = Favorite.new(favorite_params)
	  	if @favorite.save
	      flash[:sucesss] = "Recipe added to Favorites!"
	  		redirect_to @favorite.recipe
	  	else
	  		render 'new'
	  	end
	  end

	  def destroy
	  	@recipe = Recipe.find(params[:id])
	  	@favorite = Favorite.where(recipe_id: @recipe.id, user_id: current_user.id).take
	  	@favorite.destroy
	  	respond_to do |format|
	  		format.html { redirect_to @recipe, notice: 'Recipe removed' }
	  		format.json { head :no_content }
	  	end
	  end

  private
  	def favorite_params
  		params.require(:favorite).permit(:user_id, :recipe_id)
  	end
end

