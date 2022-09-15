class PostsController < ApplicationController
  before_action :set_post, only: :index
  def index
    @posts = Post.all
  end

  def create
  end

  private
  def set_post
    @post = Post.new
  end
end
