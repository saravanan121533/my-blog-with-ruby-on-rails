class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    like          = Like.new
    post          = Post.find(params[:post_id])
    like.post     = post
    like.user     = current_user
    if like.save
      # LikesMailer.notify_blog_owner(like).deliver_later
      redirect_to(post_path(post), notice: "Thanks for liking!")
    else
      redirect_to(post_path(post), alert: "Can't like! Liked already?")
    end
  end

  def destroy
    post          = Post.find(params[:post_id])
    like          = current_user.likes.find(params[:id])
    if(like.destroy)
      redirect_to(post_path(post), notice: "Removed Like to blog post.")
    else
      redirect_to(post_path(post), alert: "Error in removing Like to blog post.")
    end
  end
end
