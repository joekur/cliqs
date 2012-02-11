class ProfilesController < ApplicationController
  
  def show
    @profile = Profile.find(params[:id])
    @current_cliq = @profile.cliq
  end
  
  def edit
    
  end
  
  def update
    
  end
  
end
