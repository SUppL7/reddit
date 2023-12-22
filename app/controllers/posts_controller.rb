class PostsController < ApplicationController
  def index
    page_token = params.has_key?(:older) ? params[:older] : params[:newer]

    paginate(page_token)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @action = "edit"
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render "edit"
    end
  end


  def new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render "new"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def paginate(page_token, topic_id = nil)
    pagination = Services::Pagination.new(page_token, topic_id)

    if page_token.present?
      if params.has_key?(:newer)
        @posts = pagination.newer
      else
        @posts = pagination.older
      end
    else
      @posts = pagination.first_page
    end

    @has_newer = pagination.has_newer
    @has_older = pagination.has_older

    @page_token = pagination.construct_page_token
  end
end