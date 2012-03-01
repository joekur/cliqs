class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper, ApplicationHelper
  
  before_filter :require_login
  
  private
  
    def require_login
      unless signed_in?
        store_location
        deny_access
      end
    end
    
    def check_cliq_membership(cliq)
      if !cliq.nil?
        cliqmem = current_user.cliq_memberships.where(:cliq_id => cliq.id).first
        if !cliqmem.nil?
          return
        end
      end
      # sorry, not allowed! (we emphasize privacy!)
      flash[:error] = "Scram! You're not a member of that cliq!"
      redirect_to users_path
    end
  
end
