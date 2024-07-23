class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created: :desc)
  end
end
