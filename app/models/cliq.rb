class Cliq < ActiveRecord::Base
  include RegexHelper
  
  has_many :cliq_memberships, :dependent => :destroy
  has_many :users, :through => :cliq_memberships
  has_many :posts
  has_many :photos
  
  validates :name,  :presence => true,
                    :format => {:with => $alpha_num_regex,
                                :message => "can only contain letters, numbers, and the following symbols are allowed: [.] [_] [-]"}
  
  def self.order_stories(posts, photos)
    # creates one array ordered by relevancy (datewise)
    # assumes inputs are ordered by created_at DESC
    stories = [].concat(posts).concat(photos)
    stories.sort{|x,y| y.latest_activity <=> x.latest_activity}
  end
  
  def upcoming_birthdays
    profiles = []
    today = Time.now.month.month + Time.now.day.day
    self.users.each do |member|
      
      prof = member.profiles.where(:cliq_id => self.id).first
      if !prof.blank? && !prof.birthdate.nil?
        birthday = prof.birthdate.month.month + prof.birthdate.day.day
        if today - birthday > 0.day
          birthday += 1.year # account for wraparound december>january
        end
        if birthday-today < 30.day
          # upcoming birthday!
          profiles.concat([prof])
        end
        
      end
    end
    profiles
  end
  
end
