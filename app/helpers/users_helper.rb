module UsersHelper
  
  def gravatar_for(user, size=200)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    classname = "gravatar " + size.to_s
    image_tag(gravatar_url, :alt => user.name, :class => classname)
  end
  
  def post_pic_for(user, size)
    profile = user.profiles.where(:cliq_id => @current_cliq).first
    image_tag profile.pic_url(:post), :width => size, :height => size, :alt => user.name
  end
  
end