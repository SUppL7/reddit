class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.parent_id = params[:comment][:parent_id] if params[:comment][:parent_id].present?
    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully added.'
    else
      redirect_to post_path(@post), alert: 'Error adding comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end