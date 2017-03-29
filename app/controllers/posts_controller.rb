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

		# check error and redirect to new article
		if @post.save
			redirect_to @post
		else
			render :new
		end

	end

	# action edit for editing article
	def edit

	end

	# action update article
	def update

		# check error and redirect to change article
		if @post.update_attributes(post_params)
			redirect_to @post
		else
			render :edit
		end

	end

	# action destroy for delete article and redirect to homepage
	def destroy
		@post.destroy
		redirect_to posts_path
	end


	private

	# new method for DRY complete
	def set_post
		@post = Post.find(params[:id])
	end

	# private method with field limitation
	def post_params
		params.require(:post).permit(:title, :preview, :body)
	end

end