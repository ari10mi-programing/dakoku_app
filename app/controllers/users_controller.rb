class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to('/')
    else
      render 'users/new'
    end
  end
  
  private
  
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
  
end