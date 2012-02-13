class ProfilesController < ApplicationController
  
  def show
    @profile = Profile.find(params[:id])
    @current_cliq = @profile.cliq
  end
  
  def edit
    @profile = Profile.find(params[:id])
    @current_cliq = @profile.cliq
  end
  
  def update
    @profile = Profile.find(params[:id])
    @current_cliq = @profile.cliq
    if @profile.update_attributes(params[:profile])
      flash[:success] = "Profile saved"
      redirect_to profile_path(@profile)
    else
      render :edit
    end
  end
  
end
