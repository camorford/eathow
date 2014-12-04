class CreateRecipeIngredients < ActiveRecord::Migration
  def change
    create_table :recipe_ingredients do |t|
      t.references :ingredient, index: true
      t.references :recipe, index: true

      t.timestamps
    end
  end
end
