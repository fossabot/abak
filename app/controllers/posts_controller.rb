class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.assign_attributes(post_params)
    if @post.save
      redirect_to @post, flash: { success:  t('post.successCreate') }
    else
      flash.now[ :danger ] = t('post.errorCreate')
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to @post, flash: { success:  t('post.successUpdate') }
    else
      flash.now[ :danger ] = t('post.errorUpdate')
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, flash: { success:  t('post.successDelete') }
  end

  private

  def set_post
    begin
      @post = Post.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render layout: true, html: { message: e}, status: 404
    end
  end

  def post_params
    params.require(:post).permit(:title, :preview, :body, :category_id)
  end
end
