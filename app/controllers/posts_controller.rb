class PostsController < ApplicationController

	before_filter :set_post, only: [ :show, :edit, :update, :destroy ]

	# show all posts
	def index

		@posts = Post.all

	end

	# show just one post
	def show

		#if article is not found
		unless @post

			render text: t('post.notFound'), status: 404

		end

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

		unless @post

			render text: t('post.notFound'), status: 404

		end

	end

	# action update article
	def update

		unless @post

			render text: t('post.notFound'), status: 404

		else

			# check error and redirect to change article with flash message
			if @post.update_attributes(post_params)

				redirect_to @post, :flash => { :success =>  "Article update success" }
				
			else

				flash.now[ :danger ] = "Error updating article"
				render :edit

			end

		end

	end

	# action destroy for delete article with flash message and redirect to homepage
	def destroy

		unless @post

			render text: t('post.notFound'), status: 404

		else

			@post.destroy
			redirect_to posts_path, :flash => { :success =>  "Article delete success" }

		end

	end


	private

	# new method for DRY complete
	def set_post

		# if id is not found in db
		begin

			@post = Post.find(params[:id])

		rescue ActiveRecord::RecordNotFound => e

			@post = nil

		end

	end

	# private method with field limitation
	def post_params

		params.require(:post).permit(:title, :preview, :body, :category_id)

	end

end