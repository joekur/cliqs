class CliqMembership < ActiveRecord::Base
  
  belongs_to :cliq
  belongs_to :user
  
  #attr_protected :admin

  def receives_email_for(object)
    class_type = object.class.name
    field_name = "get_#{class_type.downcase}_email"
    read_attribute field_name.to_sym
  end
  
end