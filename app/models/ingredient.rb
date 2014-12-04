class Ingredient < ActiveRecord::Base
	has_many :user_ingredients
	has_many :recipe_ingredients
end
