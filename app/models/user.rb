class User < ActiveRecord::Base
	attr_accessor :remember_token
	
	has_many :user_ingredients
	has_many :ingredients, through: :user_ingredients

	before_save { self.email = email.downcase }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:true,
		format: {with: VALID_EMAIL_REGEX},
		uniqueness: {case_sensitive: false}

	has_secure_password
	validates :password, length: {minimum:6}, allow_blank: true
	validates :protein, :carbs, :fat, presence:true, numericality: { only_integer: true }

	validate :macros_equal_100
 
	def macros_equal_100 
  	if carbs+protein+fat != 100
  		errors.add(:recipe,"Macros have to add up to 100%")
  	end
  end

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    			BCrypt::Password.create(string, cost: cost)
	end
	
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated? (remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def macros
		[protein, carbs, fat]
	end
end