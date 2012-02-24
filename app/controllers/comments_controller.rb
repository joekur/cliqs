class CommentsController < ApplicationController
  
  def ajax_add
    @comment = Comment.new(params[:comment])
    @current_cliq = @comment.commentable.cliq
    if @comment.save
      @success = true
    else
      @success = false
    end    
  end
  
end
