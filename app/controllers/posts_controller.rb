class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	skip_before_action :authenticate_user!, :only => [:index]
	
	def index
		if params[:search]
    		@posts = Post.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 4)
  		else
    		@posts = Post.all.order('created_at DESC').paginate(page: params[:page], per_page: 4)
  		end
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new post_params
		if @post.save
			redirect_to @post, notice: "Post created"
		else
			render 'new', notice: "unable to save"
		end
	end

	def show
		@post = Post.friendly.find(params[:id])

		@prev_post = @post.previous
		@next_post = @post.next
	end

	def edit
		authorize! :edit, @post, :message => "You cannot edit this article."
	end

	def update
		if @post.update post_params
			redirect_to @post, notice: "Post successfully updated!"
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to posts_path
	end

	private

	def post_params
		params.require(:post).permit(:title, :content, :slug)
	end

	def find_post
		@post = Post.friendly.find(params[:id])
	end

end
