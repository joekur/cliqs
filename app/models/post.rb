class Post < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :cliq
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  validates :body, :presence => true
  validates :user_id, :presence => true
  validates :cliq_id, :presence => true
  
  
  def latest_activity
    times = [self.created_at]
    self.comments.each do |comment|
      times.push(comment.created_at)
    end
    times.max
  end
  
  
end