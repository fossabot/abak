class PostsController < ApplicationController

	before_filter :set_post, only: [ :show, :edit, :update, :destroy ]

	# show all posts
	def index
		@posts = Post.all
	end

	# show just one post
	def show
		
	end

	# action new for create new article
	def new
		@post = Post.new
	end

	# action create after input data
	def create
		@post = Post.new(post_params)

		# check error and redirect to new article with flash message
		if @post.save
			redirect_to @post, :flash => { :success =>  "Article create success" }
		else
			flash.now[ :danger ] = "Error create article"
			render :new
		end

	end

	# action edit for editing article
	def edit

	end

	# action update article
	def update

		# check error and redirect to change article with flash message
		if @post.update_attributes(post_params)
			redirect_to @post, :flash => { :success =>  "Article update success" }
		else
			flash.now[ :danger ] = "Error updating article"
			render :edit
		end

	end

	# action destroy for delete article with flash message and redirect to homepage
	def destroy
		@post.destroy
		redirect_to posts_path, :flash => { :success =>  "Article delete success" }
	end


	private

	# new method for DRY complete
	def set_post
		@post = Post.find(params[:id])
	end

	# private method with field limitation
	def post_params
		params.require(:post).permit(:title, :preview, :body, :category_id)
	end

end