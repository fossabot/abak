# -*- encoding : utf-8 -*-
class PostsController < ApplicationController

  before_filter :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.all
  end

  def show
    #if article is not found
    unless @post
      render text: t('post.notFound'), status: 404
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, :flash => { :success =>  'Article create success' }
    else
      flash.now[ :danger ] = 'Error create article'
      render :new
    end
  end

  def edit
    unless @post
      render text: t('post.notFound'), status: 404
    end
  end

  def update
    unless @post
      render text: t('post.notFound'), status: 404
    else
      if @post.update_attributes(post_params)
        redirect_to @post, :flash => { :success =>  'Article update success' }
      else
        flash.now[ :danger ] = 'Error updating article'
        render :edit
      end
    end
  end

  def destroy
    unless @post
      render text: t('post.notFound'), status: 404
    else
      @post.destroy
      redirect_to posts_path, :flash => { :success =>  'Article delete success' }
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
    params.require(:post).permit(:title, :preview, :body, :category_id)
  end
end
