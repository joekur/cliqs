class PostsController < ApplicationController
  
  def ajax_add
    @post = Post.new(params[:post])
    if @post.user_id==current_user.id && @post.save
      @success = true
    else
      @success = false
    end    
  end
  
  def destroy
    @post = Post.find(params[:id])
    @success = false
    if @post.user.id == current_user.id
      if @post.destroy
        @success = true
      end
    end
  end
  
 
end
