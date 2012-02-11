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
    pattern_http = /^((?:https?:\/\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'\".,<>?«»“”‘’]))/
    pattern_www = /^((www\d{0,3}[.])(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'\".,<>?«»“”‘’]))/
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
  
end
