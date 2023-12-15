class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:create, :new, :edit, :destroy]
  before_action :load_post, only: [:show, :edit, :update, :destroy]


  def index

    page_token = params.has_key?(:older) ? params[:older] : params[:newer]

    paginate(page_token)
  end


  def show
    @post = Post.find(params[:id])
    @comments = @post.commontator_thread.comments.includes(:creator)
  end

  def edit
    @action = "edit"
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path, notice: "Пост успешно удален"
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def load_post
    @post = Post.find(params[:id])
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