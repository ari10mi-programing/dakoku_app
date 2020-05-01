class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :set_current_user
  
  def set_current_user
    if session[:user_id]
      @current_user||=User.find_by(id: session[:user_id])
    end
  end
  
  def authenticate_user
    if @current_user==nil
      flash[:warning]="ログインが必要です"
      redirect_to login_path
    end
  end
  
  def forbit_login_user
    if @current_user
      flash[:warning]="すでにログインしています"
      redirect_to '/index'
    end
  end
  
end
