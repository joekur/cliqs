class PostsController < ApplicationController
  
  def ajax_add
    @post = Post.new(params[:post])
    if @post.save
      @success = true
    else
      @success = false
    end    
  end
  
 
end
