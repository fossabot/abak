class CategoriesController < ApplicationController
  before_action :set_category, only: [ :show, :edit, :update, :destroy, :add ]

  def index
    @categories = Category.all
  end

  def show
    if @category.nil?
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
    @categories = Category.where("id = #{params[:id]}").order(:name)
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, flash: { success:  t('cat.successCreate') }
    else
      if @categories.nil?
        @categories = Category.order(:name)
        flash.now[ :danger ] = t('cat.errorAdd')
        render :add
      else
        @categories = Category.where("id != #{params[:id]}").order(:name)
        flash.now[ :danger ] = t('cat.errorCreate')
        render :new
      end
    end
  end

  def edit
    if @category.nil?
      render text: t('cat.notFound'), status: 404
    else
      @categories = Category.where("id != #{params[:id]}").order(:name)
    end
  end

  def update
    if @category.nil?
      render text: t('cat.notFound'), status: 404
    else
      @category.assign_attributes(category_params)
      if @category.save
        redirect_to categories_path, flash: { success:  t('cat.successUpdate') }
      else
        @categories = Category.where("id != #{params[:id]}").order(:name)
        flash.now[ :danger ] = t('cat.errorUpdate')
        render :edit
      end
    end
  end

  def destroy
    if @category.nil?
      render text: t('cat.notFound'), status: 404
    else
      @category.destroy
      redirect_to categories_path, flash: { success:  t('cat.successDelete') }
    end
  end

  private

  def set_category
    begin
      @category = Category.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @category = nil
    end
  end

  def category_params
    params.permit(:name, :parent_id)
  end
end
