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
  
end
