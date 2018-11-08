class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i(show index)
  before_action :load_post, only: %i(show edit update destroy)

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    if post.save
      redirect_to post
    else
      @post = post
      render 'new'
    end
  end

  def show
  end

  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to @post
    else
      redirect_to 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
