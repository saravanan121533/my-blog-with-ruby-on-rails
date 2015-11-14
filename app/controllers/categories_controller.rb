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
    @category = Category.find(params[:id])
  end

end
