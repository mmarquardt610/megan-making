class LandingController < ApplicationController
  def index
    @latest_post = Post.last

    render 'index'
  end
end
