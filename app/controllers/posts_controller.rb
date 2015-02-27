class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  
  def index
  end
  
  def new
    @post = Post.new
  end
  
  def create
    all_params = post_params
    all_params[:user_id] = current_user.id
    @post = Post.new(all_params)
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end
  
  private
  
    def post_params
      params.require(:post).permit(:title, :body)
    end
    
    def logged_in_user
      unless logged_in?
        redirect_to login_url
      end
    end
end
