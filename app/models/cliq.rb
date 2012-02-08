class Cliq < ActiveRecord::Base
  
  has_many :cliq_memberships
  has_many :users, :through => :cliq_memberships
  
end
