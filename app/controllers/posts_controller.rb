class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :correct_user_or_admin, only: [:edit, :update, :destroy]
	before_action :restrict_guest_user, only: [:new, :create, :edit, :update, :destroy]
  
	def index
	  @posts = Post.all
	end
  
	def show
	end
  
	def new
	  @post = Post.new
	end
  
	def create
	  @post = current_user.posts.build(post_params)
	  if @post.save
		redirect_to posts_path, notice: 'Post was successfully created.'
	  else
		render :new
	  end
	end
  
	def edit
	end
  
	def update
	  if @post.update(post_params)
		redirect_to posts_path, notice: 'Post was successfully updated.'
	  else
		render :edit
	  end
	end
  
	def destroy
	  @post.destroy
	  redirect_to posts_path, notice: 'Post was successfully destroyed.'
	end
  
	private
  
	def set_post
	  @post = Post.find(params[:id])
	end
  
	def correct_user_or_admin
	  redirect_to(posts_path, alert: "Not authorized") unless @post.user == current_user || current_user.admin?
	end
  
	def restrict_guest_user
	  redirect_to posts_path, alert: "Not authorized as guest user" if session[:guest_user]
	end
  
	def post_params
	  params.require(:post).permit(:title, :content)
	end
  end
  
  
  