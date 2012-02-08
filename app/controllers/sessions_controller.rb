class SessionsController < ApplicationController
  layout 'front'
  
  # login page
  def new
  end
  
  # login action
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid login info"
      render :new
    else
      sign_in user
      redirect_to root_path #todo
    end
  end
  
  # logout action
  def destroy
    sign_out
    flash[:success] = "Come back soon!"
    redirect_to root_path
  end
  
end
