class Photo < ActiveRecord::Base
  
  attr_accessible :body, :image, :remote_image_url
  
  belongs_to :cliq
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  mount_uploader :image, ImageUploader
  
  validates :image, :presence => true
  
end
