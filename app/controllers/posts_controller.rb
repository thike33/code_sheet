class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
    @post.codes.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, success: t('defaults.flash_message.created', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_created', item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.includes(:codes).find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), success: t('defaults.flash_message.updated', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, success: t('defaults.flash_message.destroyed', item: Post.model_name.human), status: :see_other
  end

  def user_index
    @posts = Post.includes(:user).where(user_id: params[:id]).order(created_at: :desc).page(params[:page])
  end

  def bookmarks
    @posts = current_user.bookmark_posts.order(created_at: :desc).page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image, :image_cache, codes_attributes: [:id, :language, :body, :_destroy])
  end
end
