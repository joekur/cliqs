class Post < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :cliq
  has_many :comments, :dependent => :destroy
  
  validates :body, :presence => true
  validates :user_id, :presence => true
  validates :cliq_id, :presence => true
  
  
end