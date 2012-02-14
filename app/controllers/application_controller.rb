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
  
end
