class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]
  
  def index
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "New account successfully created!"
      redirect_to root_path
    else
      render :new
    end
  end
  
end
