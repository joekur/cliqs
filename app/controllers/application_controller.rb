class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  before_filter :require_login
  
  private
  
    def require_login
      deny_access unless signed_in?
    end
  
end
