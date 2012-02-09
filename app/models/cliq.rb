class Cliq < ActiveRecord::Base
  
  has_many :cliq_memberships, :dependent => :destroy
  has_many :users, :through => :cliq_memberships
  
  alpha_num_regex = /\A[a-z0-9\._-]+\z/i
  
  validates :name,  :presence => true,
                    :format => {:with => alpha_num_regex,
                                :message => "can only contain letters, numbers, and the following symbols are allowed: [.] [_] [-]"}
  
end
