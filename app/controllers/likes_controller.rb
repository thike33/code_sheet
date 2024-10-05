class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    @post.update_likes_count
  end

  def destroy
    @post = Post.find(params[:id])
    current_user.unlike(@post)
    @post.update_likes_count
  end
end
