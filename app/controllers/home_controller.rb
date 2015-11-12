class HomeController < ApplicationController
  def home
    @categories = Category.all
    @posts = Post.all
  end
end
