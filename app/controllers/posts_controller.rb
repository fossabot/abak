class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.all
  end

  def show
    if @post.nil?
      render text: t('post.notFound'), status: 404
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, flash: { success:  t('post.successCreate') }
    else
      flash.now[ :danger ] = t('post.errorCreate')
      render :new
    end
  end

  def edit
    unless @post
      render text: t('post.notFound'), status: 404
    end
  end

  def update
    if @post.nil?
      render text: t('post.notFound'), status: 404
    else
      if @post.update_attributes(post_params)
        redirect_to @post, flash: { success:  t('post.successUpdate') }
      else
        flash.now[ :danger ] = t('post.errorUpdate')
        render :edit
      end
    end
  end

  def destroy
    if @post.nil?
      render text: t('post.notFound'), status: 404
    else
      @post.destroy
      redirect_to posts_path, flash: { success:  t('post.successDelete') }
    end
  end

  private

  def set_post
    begin
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @post = nil
    end
  end

  def post_params
    params.permit(:title, :preview, :body, :category_id)
  end
end
