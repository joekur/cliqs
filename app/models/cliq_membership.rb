class CliqMembership < ActiveRecord::Base
  
  belongs_to :cliq
  belongs_to :user
  
  #attr_protected :admin
  
end