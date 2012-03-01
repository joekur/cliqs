class PhotosController < ApplicationController
  
  def new
    @current_cliq = Cliq.find(params[:cliq_id])
    check_cliq_membership(@current_cliq)
    @photo = Photo.new
  end
  
  def create
     @current_cliq = Cliq.find(params[:cliq_id])
     check_cliq_membership(@current_cliq)
     @photo = Photo.new(params[:photo])
     @photo.cliq_id = @current_cliq.id
     @photo.user_id = current_user.id
     if @photo.save
       flash['success'] = "Photo saved!"
       redirect_to @current_cliq
     else
       flash.now['error'] = "Error saving photo"
       render 'new'
     end
  end
  
  def show
    @current_cliq = Cliq.find(params[:cliq_id])
    check_cliq_membership(@current_cliq)
    @photo = Photo.find(params[:id])
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @success = false
    if @photo.user.id == current_user.id
      if @photo.destroy
        @success = true
      end
    end
  end
  
end
