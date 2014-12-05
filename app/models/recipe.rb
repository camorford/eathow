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

    #ATTEMPT AT VALIDATING INGREDIENT SO IT'S NOT BLANK
    # def name_not_blank
    #   if ingredients_attributes['name'].blank?
    #     errors.add(ingredients_attributes['name'],"ingredients can't be left empty")
    #   end
    # end

    # Method returns a collection of recipes from the database
    def self.macros(user_macros)
    	protein = user_macros[0]
    	carbs = user_macros[1]
    	fat = user_macros[2]

    	min_protein = protein - 5
    	max_protein = protein + 5

    	min_carbs = carbs - 5
    	max_carbs = carbs + 5

    	min_fat = fat - 5
    	max_fat = fat + 5

    	where(protein: min_protein..max_protein).where(carbs: min_carbs..max_carbs).where(fat:min_fat..max_fat)
		end

		def dailycalories(user_calories)
      if user_calories
        calories.to_f/user_calories
      else
        calories
      end
		end
end