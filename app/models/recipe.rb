class Recipe < ActiveRecord::Base
	has_many :recipe_ingredients
	has_many :ingredients, through: :recipe_ingredients
	accepts_nested_attributes_for :ingredients, :reject_if => :all_blank, :allow_destroy => true

	validates :name,:directions,:calories,:protein,:carbs,:fat,presence:true
	validates :calories,:protein,:carbs,:fat,numericality: { only_integer: true }

	validate :macros_equal_100
 
  	def macros_equal_100 
    	if carbs+protein+fat != 100
    		errors.add(:recipe,"Macros have to add up to 100%")
    	end
    end

end