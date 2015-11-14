class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
  end

  def show
    # for specific category display of blog, this is when a user will click
    # the side bar on a specific category
    @posts = Post.where(category_id: params[:id]).order(updated_at: :desc)
    # for side_bar display of categories
    @categories = Category.all
  end

end
