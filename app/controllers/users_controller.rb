class UsersController < ApplicationController
  
  before_action :forbit_login_user, {only:[:new, :create]}
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      login @user
      flash[:success]="新規登録が完了しました。"
      redirect_to '/index'
    else
      render 'users/new'
    end
  end
  
  private
  
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
  
  
end
