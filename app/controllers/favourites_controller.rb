class FavouritesController < ApplicationController
  
  before_action :authenticate_user

  def create
    fav      = current_user.favourites.new
    @post    = Post.find params[:post_id]
    fav.post = @post

    respond_to do |format|
      if(fav.save)
        format.html { redirect_to post_path(@post), notice: "Blog Post Favourited!" }
        format.js   { render :favourited_success}
      else
        format.html { redirect_to post_path(@post), alert: "Error occured during favouriting a blog!" }
        format.js   { render }
      end
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    fav   = current_user.favourites.find params[:id]
    respond_to do |format|
      if(fav.destroy)
        format.html { redirect_to post_path(@post), notice: "Removed Favourite on Blog Post!" }
        format.js   { render :unfavourited_success }
      else
        format.html { redirect_to post_path(@post), alert: "Error occured during remove favourite of a blog!" }
        format.js   { render }
      end
    end
  end
  
end
