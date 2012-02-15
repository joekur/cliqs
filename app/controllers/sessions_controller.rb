class SessionsController < ApplicationController
  layout 'front'
  skip_before_filter :require_login, :only => [:new, :create]
  
  # login page
  def new
    if signed_in?
      redirect_to users_path
    end
  end
  
  # login action
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid login info"
      render :new
    else
      sign_in user
      redirect_back_or users_path
    end
  end
  
  # logout action
  def destroy
    sign_out
    flash[:success] = "Come back soon!"
    redirect_to root_path
  end
  
end
