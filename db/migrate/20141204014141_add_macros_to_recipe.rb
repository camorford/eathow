class AddMacrosToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :carbs, :integer
    add_column :recipes, :protein, :integer
    add_column :recipes, :fat, :integer
    add_column :recipes, :calories, :integer
  end
end
