class AddNutritionPictureToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :nutrition_picture, :string
  end
end
