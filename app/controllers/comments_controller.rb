class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :correct_user_or_admin, only: [:edit, :update, :destroy]
  before_action :restrict_guest_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
    if params[:post_id]
      post = Post.find_by(id: params[:post_id])
      @comment.post = post
    end
  end

  def create
    @comment = current_user.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.post, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @comment.post, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
    @post = @comment.post
  end

  def correct_user_or_admin
    redirect_to(@comment.post, alert: "Not authorized") unless @comment.user == current_user || current_user.admin?
  end

  def restrict_guest_user
    redirect_to posts_path, alert: "Not authorized as guest user" if session[:guest_user]
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end





