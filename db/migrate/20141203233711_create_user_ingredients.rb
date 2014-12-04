class CreateUserIngredients < ActiveRecord::Migration
  def change
    create_table :user_ingredients do |t|
      t.references :user, index: true
      t.references :ingredient, index: true

      t.timestamps
    end
  end
end
