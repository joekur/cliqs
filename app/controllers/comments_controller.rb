class CommentsController < ApplicationController
  
  def ajax_add
    @comment = Comment.new(params[:comment])
    if @comment.save
      @success = true
    else
      @success = false
    end    
  end
  
end
