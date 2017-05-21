class CategoriesController < ApplicationController
  before_action :set_category, only: [ :show, :edit, :update, :destroy, :add ]

  def index
    @categories = Category.all
  end

  def show
    @categories = Category.order(:name)
    @posts = Post.where(category_id: [@category.subtree_ids])
  end

  def new
    @category = Category.new
    @categories = Category.order(:name)
  end

  def add
    @categories = Category.where("id = #{@category.id}").order(:name)
  end

  def create
    @category = Category.new
    @category.assign_attributes(category_params)
    if @category.save
      redirect_to @category, flash: { success:  t('cat.successCreate') }
    else
      if @categories.nil?
        @categories = Category.order(:name)
        flash.now[ :danger ] = t('cat.errorAdd')
        render :add
      else
        @categories = Category.where("id != #{@category.id}").order(:name)
        flash.now[ :danger ] = t('cat.errorCreate')
        render :new
      end
    end
  end

  def edit
    @categories = Category.where("id != #{@category.id}").order(:name)
  end

  def update
    @category.assign_attributes(category_params)
    if @category.save
      redirect_to categories_path, flash: { success:  t('cat.successUpdate') }
    else
      @categories = Category.where("id != #{@category.id}").order(:name)
      flash.now[ :danger ] = t('cat.errorUpdate')
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, flash: { success:  t('cat.successDelete') }
  end

  private

  def set_category
    begin
      @category = Category.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render layout: true, html: t('cat.notFound'), status: 404
    end
  end

  def category_params
    params.permit(:name, :parent_id)
  end
end
