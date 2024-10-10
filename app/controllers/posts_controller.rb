class PostsController < ApplicationController
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user, :tags).status_public.order(created_at: :desc).page(params[:page])
    if params[:sort] == 'likes'
      @posts = @q.result(distinct: true).includes(:user, :tags).order(likes_count: :desc, created_at: :desc).page(params[:page])
    end
  end

  def new
    @post = Post.new
    @post.codes.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save_with_tags(tag_names: params.dig(:post, :tag_names).split(',').uniq)
      redirect_to posts_path, success: t('defaults.flash_message.created', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_created', item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.includes(:codes).find(params[:id])
    if @post.status_private? && @post.user != current_user
      redirect_to posts_path, danger: t('defaults.flash_message.cannot_be_accessed')
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.assign_attributes(post_params)
    if @post.save_with_tags(tag_names: params.dig(:post, :tag_names).split(',').uniq)
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
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).where(user_id: params[:id]).includes(:tags).order(created_at: :desc).page(params[:page])
    if params[:sort] == 'likes'
      @posts = @q.result(distinct: true).where(user_id: params[:id]).includes(:tags).order(likes_count: :desc, created_at: :desc).page(params[:page])
    end
  end

  def bookmarks
    @q = current_user.bookmark_posts.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user, :tags).order(created_at: :desc).page(params[:page])
    if params[:sort] == 'likes'
      @posts = @q.result(distinct: true).includes(:user, :tags).order(likes_count: :desc, created_at: :desc).page(params[:page])
    end
  end

  def tags
    @q = Post.ransack(params[:q])
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.includes(:user, :tags).status_public.order(created_at: :desc).page(params[:page])
    if params[:sort] == 'likes'
      @posts = @tag.posts.includes(:user, :tags).status_public.order(likes_count: :desc, created_at: :desc).page(params[:page])
    end
  end

  def search
    @posts = Post.where("title like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image, :image_cache, :status, codes_attributes: [:id, :language, :body, :_destroy])
  end
end
