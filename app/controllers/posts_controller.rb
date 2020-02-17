class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @post = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      # @user = User.find(params[:id])

      if @post.save
        redirect_to @post, notice: 'Your post was created successfully'
      else
        render :new
      end
    end

  def show

  end

  def destroy
    @post.destroy
    
    redirect_to posts_path, notice: 'Your post was deleted successfully'
  end

  def edit 
  end
  def update 
    
    if @post.update(post_params)
      redirect_to posts_path, notice: 'Your post was updated successfully'
    else
      render :edit
    end
  end

    private

      def post_params
        params.require(:post).permit(:title, :postimage, :remove_postimage, :details)
      end

      def set_post
        @post = Post.find(params[:id])
      end
end
