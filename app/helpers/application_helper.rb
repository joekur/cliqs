module ApplicationHelper
  include RegexHelper
  
  # return a title on a per-page basis
  def title
    base_title = "Cliqs"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def linkify(str)
    # wrap <a> tags around any valid URLs in given string
    #pattern_http = /^((?:https?:\/\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'\".,<>?«»“”‘’]))/
    #pattern_www = /^((www\d{0,3}[.])(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'\".,<>?«»“”‘’]))/
    pattern_http = /^((?:https?:\/\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)))/
    pattern_www = /^((www\d{0,3}[.])(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)))/
    replace_http = "<a href=\"\\0\" rel=\"nofollow\">\\0</a>" 
    replace_www = "<a href=\"http://\\0\" rel=\"nofollow\">\\0</a>"
    
    str.gsub! pattern_http do
      %Q|<a href="#{$1}" rel="nofollow">#{$1}</a>|
    end
    str.gsub! pattern_www do
      %Q|<a href="http://#{$1}" rel="nofollow">#{$1}</a>|
    end
    
    return str
  end
  
  def post_profile(post) # works for either post or comment
    cliq_id = post.cliq.id
    post.user.profiles.where(:cliq_id => cliq_id).first
  end
  
  def comment_profile(comment)
    cliq_id = comment.post.cliq.id
    comment.user.profiles.where(:cliq_id => cliq_id).first
  end
  
  def nl2br(str)
    str = h str
    str = str.gsub("\n\r","<br>").gsub("\r", "").gsub("\n", "<br />")
    str.html_safe
  end
  
end
