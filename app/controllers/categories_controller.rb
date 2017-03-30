class CategoriesController < ApplicationController

	before_filter :set_category, only: [ :show, :edit, :update, :destroy, :add ]

	# show all categories
	def index
		@categories = Category.all
	end

	# show just one category and tree of this
	def show
		@posts = Post.where(category_id: [@category.subtree_ids])
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
			@categories = Category.where("id != #{@category.id}").order(:name)
			flash.now[ :danger ] = "Error create category"
			render :new
		end

	end

	# action edit for editing category
	def edit
		@categories = Category.where("id != #{@category.id}").order(:name)
	end

	# action update category
	def update
		# check error and redirect to change category with flash message
		if @category.update_attributes(category_params)
			redirect_to categories_path, :flash => { :success =>  "Category update success" }
		else
			@categories = Category.where("id != #{@category.id}").order(:name)
			flash.now[ :danger ] = "Error updating category"
			render :edit
		end

	end

	# action destroy for delete category with flash message and redirect to homepage
	def destroy
		@category.destroy
		redirect_to categories_path, :flash => { :success =>  "Category delete success" }
	end


	private

	# new method for DRY complete
	def set_category
		@category = Category.find(params[:id])
	end

	# private method with field limitation
	def category_params
		params.require(:category).permit(:name, :parent_id)
	end

end