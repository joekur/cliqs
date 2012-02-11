module RegexHelper
  
  def regex_validates(str, regex)
    !regex.match(str).nil?
  end
  
  def email_regex
    /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  end
  
  def az_regex # a-z, case insensitive
    /\A[a-z]*\z/i
  end
  
  def alpha_num_regex
    /\A[a-z0-9\._-]+\z/i
  end
  
end