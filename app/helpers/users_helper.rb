module UsersHelper
  
  def gravatar_for(user, size=200)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    classname = "gravatar " + size.to_s
    image_tag(gravatar_url, :alt => user.name, :class => classname)
  end
  
end