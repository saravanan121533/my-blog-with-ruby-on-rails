class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    like          = Like.new
    post          = Post.find(params[:post_id])
    like.post     = post
    like.user     = current_user

    # ajaxifying likes
    respond_to do |format|
      if like.save
        # LikesMailer.notify_blog_owner(like).deliver_later
        format.html { redirect_to(post_path(post)) }
        format.js   { render :like_success, locals: {post: post} }
      else
        format.html { render(post_path(post), alert: "Can't like! Liked already?") }
        format.js   { render }
      end
    end # end of ajax
  end

  def destroy
    post          = Post.find(params[:post_id])
    like          = current_user.likes.find(params[:id])

    # ajaxifying likes
    respond_to do |format|
      if(like.destroy)
        format.html { redirect_to(post_path(post), notice: "Removed Like to blog post.") }
        format.js { render :unlike_success, locals: {post: post} }
      else
        format.html { redirect_to(post_path(post), alert: "Error in removing Like to blog post.") }
        format.js { render }
      end
    end
  end
end
