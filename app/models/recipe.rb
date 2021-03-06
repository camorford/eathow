class Recipe < ActiveRecord::Base
  scope :matching, -> { where(:matching => true) }

  before_save :check_ingredients
  has_many :recipe_ingredients
  has_many :favorites, dependent: :destroy
	has_many :ingredients, through: :recipe_ingredients

	accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

  mount_uploader :picture, PictureUploader
  mount_uploader :nutrition_picture, PictureUploader 

	validates :name,:directions,:calories,:protein,:carbs,:fat,presence:true
	validates :calories,:protein,:carbs,:fat,numericality: { only_integer: true }

	validate :macros_equal_100, :picture_size, :nutrition_pic_size

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

  def self.match(user)
    RecipeIngredient.where(:ingredient => user.ingredients).map(&:recipe).select { |recipe| (recipe.ingredients & user.ingredients) == recipe.ingredients}
  end

	def dailycalories(user_calories)
    if user_calories
      (calories.to_f/user_calories)*100
    else 
      calories
    end
	end

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

    def nutrition_pic_size
      if nutrition_picture.size > 5.megabytes
        errors.add(:nutrition_picture, "should be less than 5MB")
      end
    end

    def check_ingredients
      ingredients = self.ingredients.map(&:name).map do |ingredient_name|
      Ingredient.find_or_create_by(name: ingredient_name)
    end

      self.ingredients.clear
      self.ingredients = ingredients
    end

    def macros_equal_100 
      if carbs+protein+fat != 100
        errors.add(:recipe,"Macros have to add up to 100%")
      end
    end
end