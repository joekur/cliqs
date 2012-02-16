class Photo < ActiveRecord::Base
  
  attr_accessible :body, :image, :remote_image_url
  belongs_to :cliq
  belongs_to :user
  mount_uploader :image, ImageUploader
  
end
