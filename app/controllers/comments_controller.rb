class CommentsController < ApplicationController

  def create
    comment_params = params.require(:comment).permit(:body)
    @post = Post.find params[:post_id]
    @comment = Comment.new(comment_params)

    # associates the comment with the post
    @comment.post = @post

    # check if successful db query
    if @comment.save
      redirect_to post_path(@post), notice: "Comment created successfully!"
    else
      render "posts/show"
    end
  end
end
