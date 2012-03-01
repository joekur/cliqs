class ProfilesController < ApplicationController
  
  before_filter :check_profile_ownership, :except => [:show]
  
  def show
    @profile = Profile.find(params[:id])
    @current_cliq = @profile.cliq
    check_cliq_membership(@current_cliq)
    if @profile.user.id == current_user.id
      @is_myprofile = true
    else
      @is_myprofile = false
    end
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
  
  def edit_prof_pic
    @profile = Profile.find(params[:id])
    @current_cliq = @profile.cliq
  end
  
  def update_prof_pic
    @profile = Profile.find(params[:id])
    @current_cliq = @profile.cliq
    if @profile.update_attributes(params[:profile])
      flash[:success] = "Profile picture updated!"
      redirect_to profile_path(@profile)
    else
      render 'edit_prof_pic'
    end
  end
  
  def ajax_add_prof_pic
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      @success = true
      image = @profile.image
      @width = image['width']
      @height = image['height']
    else
      @success = false
    end
  end
  
  
  
  private
    
    def check_profile_ownership
      if defined?(params[:id])
        profile = Profile.find(params[:id])
        if profile.user.id != current_user.id
          # sorry, not allowed! (we emphasize privacy!)
          flash[:error] = "That's not your profile!"
          redirect_to users_path
        end
      end
    end
  
end
