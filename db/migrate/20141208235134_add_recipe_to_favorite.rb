class AddRecipeToFavorite < ActiveRecord::Migration
  def change
    add_reference :favorites, :recipe, index: true
  end
end
