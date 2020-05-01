class HomeController < ApplicationController
  
  before_action :authenticate_user, {only:[:index]}
  before_action :forbit_login_user, {only:[:top]}
  
  def top
  end
  
  def index
    
  end
end
