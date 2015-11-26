class FavouritesController < ApplicationController
  before_action :authenticate_user

  def create
    fav  = current_user.favourites.new
    post = Post.find params[:post_id]
    fav.post = post
    
    if fav.save
      redirect_to post_path(post), notice: "Blog Post Favourited!"
    else
      redirect_to post_path(post), alert: "Error occured during favouriting a blog!"
    end
  end

  def destroy
    post = Post.find params[:post_id]
    fav      = current_user.favourites.find params[:id]
    fav.destroy
    redirect_to post_path(post), notice: "Removed Favourite on Blog Post!"
  end
end
