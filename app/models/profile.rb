class Profile < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :cliq
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  mount_uploader :pic, ProfilePicUploader
  
  def image
    @image ||= MiniMagick::Image.open(pic.url)
  end
  
end
