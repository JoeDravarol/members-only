class PostsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    if @post.save
      flash[:success] = "Post succesfully created"
      redirect_to posts_path
    else
      flash[:danger] = "Title or content must be present"
      render 'new'
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :content)
    end

    # Check if user is signed in
    def signed_in_user
      unless signed_in?
        flash[:danger] = "Please sign in"
        redirect_to new_session_path
      end
    end
end
