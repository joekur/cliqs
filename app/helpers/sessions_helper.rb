module SessionsHelper
  
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = user.id;
    self.current_user = user;
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil;
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  private #------------------------------------------------------
  
    def user_from_remember_token
      id = remember_token
      id ? User.find_by_id(id) : nil
    end
    
    def remember_token
      cookies.signed[:remember_token] || nil
    end
  
  
end
