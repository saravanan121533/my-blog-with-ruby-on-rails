class CommentsController < ApplicationController

  before_action(:authenticate_user, {except: [:index, :show]})
  before_action(:find_comment, {only: [:edit, :update, :destroy, :show]})
  before_action(:authorize, {only: [:edit, :update, :destroy]})

  def create
    @post          = Post.find params[:post_id]
    comment_params = params.require(:comment).permit(:body)
    @comment       = Comment.new(comment_params)
    @comment.post  = @post
    @comment.user  = current_user

    respond_to do |format|
      if @comment.save
        BlogMailer.notify_blog_owner(@comment).deliver_later
        format.html { redirect_to post_path(@post), notice: "Comment created successfully!" }
        format.js   { render :comment_success }
      else
        format.html { render "posts/show" }
        format.js   { render }
      end
    end
  end

  def edit
    # calls before action callback find_comment
  end

  def update
    # calls before action callback find_comment
    if @comment.update(comment_params)
      redirect_to post_path(params[:post_id])
    else
      render :edit
    end
  end

  def destroy
    # ajaxifying comment
    respond_to do |format|
      # calls before action callback find_comment
      if @comment.destroy
        format.html { redirect_to post_path(params[:post_id]) }
        format.js   { render :delete_comment }
      else
        flash[:alert] = "Error in comment delete."
        format.html { redirect_to post_path(params[:post_id]) }
        format.js   { render }
      end
    end
  end

  def show
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
    @post    = Post.find(params[:post_id])
  end

  def comment_params
    comment_params = params.require(:comment).permit(:body)
  end

  def authorize
    redirect_to root_path, alert: "Access denied!" unless can? :manage, @comment
  end
end
