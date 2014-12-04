class RemoveServingSizeFromIngredient < ActiveRecord::Migration
  def change
    remove_column :ingredients, :serving_size, :integer
  end
end
