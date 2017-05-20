# -*- encoding : utf-8 -*-
class CategoriesController < ApplicationController
  before_action :set_category, only: [ :show, :edit, :update, :destroy, :add ]

  def index
    @categories = Category.all
  end

  def show
    unless @category
      render text: t('cat.notFound'), status: 404
    else
      @posts = Post.where(category_id: [@category.subtree_ids])
    end
  end

  def new
    @category = Category.new
    @categories = Category.order(:name)
  end

  def add
    @categories = Category.where("id = #{@category.id}").order(:name)
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, flash: { success:  'Category create success' }
    else
      if @categories.nil?
        @categories = Category.order(:name)
        flash.now[ :danger ] = 'Error adding category'
        render :add
      else
        @categories = Category.where("id != #{@category.id}").order(:name)
        flash.now[ :danger ] = 'Error create category'
        render :new
      end
    end
  end

  def edit
    unless @category
      render text: t('cat.notFound'), status: 404
    else
      @categories = Category.where("id != #{@category.id}").order(:name)
    end
  end

  def update
    unless @category
      render text: t('cat.notFound'), status: 404
    else
      if @category.update_attributes(category_params)
        redirect_to categories_path, flash: { success:  'Category update success' }
      else
        @categories = Category.where("id != #{@category.id}").order(:name)
        flash.now[ :danger ] = 'Error updating category'
        render :edit
      end
    end
  end

  def destroy
    unless @category
      render text: t('cat.notFound'), status: 404
    else
      @category.destroy
      redirect_to categories_path, flash: { success:  'Category delete success' }
    end
  end

  private

  def set_category
    begin
      @category = Category.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @category = nil
    end
  end

  def category_params
    params.permit(:name, :parent_id)
  end
end
