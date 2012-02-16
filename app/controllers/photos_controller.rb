class PhotosController < ApplicationController
  
  def new
    @current_cliq = Cliq.find(params[:cliq_id])
    @photo = Photo.new
  end
  
  def create
     @current_cliq = Cliq.find(params[:cliq_id])
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
  
end
