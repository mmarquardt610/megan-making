class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i(show index)
  before_action :load_post, only: %i(show edit update destroy)

  def index
    @posts = Post.order(created_at: :desc)
    respond_to do |format|
      format.html
      format.rss { render layout: false }
    end
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

  def new_release_notes
    cards_by_label = completed_cards.group_by { |c| c.labels.first.name }
    content = cards_by_label.map do |label, cards|
      "### #{label}\n\n" + cards.map { |c| "* #{c.name}" }.join("\n")
    end.join("\n\n")

    title = "Weekly Release Notes - #{Date.today.strftime('%b %e, %Y')}"
    @post = Post.new(content: content, title: title)

    render 'new'
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

  def completed_cards
    @completed_cards ||=
      Trello::Board.find(ENV['TRELLO_BOARD'])
        .lists
        .find { |l| l.name == 'Done' }
        .cards
        .select { |c| c.closed == false && c.labels.first.name != 'Money maker' }
        .reverse
  end
end
