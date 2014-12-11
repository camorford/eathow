class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def check_admin
  	unless current_user.admin?
  		redirect_to root_path
  	end
  end
end
