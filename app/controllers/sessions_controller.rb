class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      login(user)
      redirect_to root_path
    else
      flash.now[:danger]="メールアドレスとパスワードの組み合わせが正しくありません。" 
      render 'sessions/new'
    end
  end
  
  def destroy
    session.delete(:user_id)
    @current_user=nil
    redirect_to root_path
  end
  
end
