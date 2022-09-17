class PostsController < ApplicationController
  before_action :set_post, only: :index
  before_action :set_posts, only: [:index, :create]

  def index
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to root_url
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.new
  end

  def set_posts
    @posts = Post.recent.page(params[:page])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
