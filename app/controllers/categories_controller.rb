# -*- encoding : utf-8 -*-
class CategoriesController < ApplicationController

	before_filter :set_category, only: [ :show, :edit, :update, :destroy, :add ]

	# show all categories
	def index

		@categories = Category.all

	end

	# show just one category and tree of this
	def show

		# if category is not found
		unless @category

			render text: t('cat.notFound'), status: 404

		else

			@posts = Post.where(category_id: [@category.subtree_ids])

		end

	end

	# action new for create new category
	def new

		@category = Category.new
		@categories = Category.order(:name)

	end

	# action add for add new category with parent current category
	def add

		# choose parent category on default and create new Category
		@categories = Category.where("id = #{@category.id}").order(:name)
		@category = Category.new

	end

	# action create after input data
	def create

		@category = Category.new(category_params)

		# check error and redirect to new category with flash message
		if @category.save

			redirect_to @category, :flash => { :success =>  "Category create success" }

		else

			# try to catch adding error
			if @categories.nil?

				@categories = Category.order(:name)
				flash.now[ :danger ] = "Error adding category"
				render :add

			else

				@categories = Category.where("id != #{@category.id}").order(:name)
				flash.now[ :danger ] = "Error create category"
				render :new

			end

		end

	end

	# action edit for editing category
	def edit

		unless @category

			render text: t('cat.notFound'), status: 404

		else

			@categories = Category.where("id != #{@category.id}").order(:name)

		end

	end

	# action update category
	def update

		unless @category

			render text: t('cat.notFound'), status: 404

		else

			# check error and redirect to change category with flash message
			if @category.update_attributes(category_params)

				redirect_to categories_path, :flash => { :success =>  "Category update success" }

			else

				@categories = Category.where("id != #{@category.id}").order(:name)
				flash.now[ :danger ] = "Error updating category"
				render :edit
	
			end

		end

	end

	# action destroy for delete category with flash message and redirect to homepage
	def destroy

		unless @category

			render text: t('cat.notFound'), status: 404

		else

			@category.destroy
			redirect_to categories_path, :flash => { :success =>  "Category delete success" }

		end

	end


	private

	# new method for DRY complete
	def set_category

		# if id is not found in db
		begin

			@category = Category.find(params[:id])

		rescue ActiveRecord::RecordNotFound => e

			@category = nil

		end

	end

	# private method with field limitation
	def category_params

		params.require(:category).permit(:name, :parent_id)

	end

end
