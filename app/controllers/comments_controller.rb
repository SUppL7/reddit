class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.parent_id = params[:comment][:parent_id] if params[:comment][:parent_id].present?
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully added.'
    else
      redirect_to post_path(@post), alert: 'Error adding comment.'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.can_be_deleted_by?(current_user)
      # Удаление комментария
      @comment.destroy
      redirect_to post_path(@comment.post), notice: 'Comment was successfully deleted.'
    else
      redirect_to post_path(@comment.post), alert: 'You are not authorized to delete this comment.'
    end
  end
  def edit
    @action = "edit"
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to post_path(@comment.post), notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end