class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :check_admin, only: [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
      flash[:sucesss] = "Thanks for joining EatHow :)"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


  def destroy
      @user = User.find(params[:id])
      @user.destroy
      respond_to do |format|
        format.html { redirect_to root_url, notice: 'User removed' }
        format.json { head :no_content }
      end
    end


  private

  	def user_params
  		params.require(:user).permit(:name,:email,:calories,:protein,:carbs,:fat,:password,:password_confirmation,ingredients_attributes:[:id,:name,:_destroy])
  	end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end 

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end 

end