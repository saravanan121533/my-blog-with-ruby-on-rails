class PostsController < ApplicationController

  # get existing post base on :id, done before action controller method is performed
  before_action(:find_post, {only: [:edit, :update, :show, :destroy]})

  # this is the controller for the index page which will show all the blog post
  def index
    @posts = Post.all.order(updated_at: :desc)
  end

  # this is the controller for the add new blog post found in nav bag
  def new
    @post = Post.new
  end

  # this is the post method for the add new blog post after user clicked
  # "Create Post" button
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  # controller for the edit page when the edit icon is clicked at show page
  # actual processing will be done at update method
  def edit
  end

  # this is the post method for edit a blog post this will be called after the
  # "Update Post" is clicked in edit page
  def update
    # get user input through params for this specific blog post
    if @post.update(post_params)
      # if update is successful show page will be displayed reflecting changes
      redirect_to posts_path
    else
      # if udpate is not successful, edit page will be displayed again
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def show
    @comment = Comment.new
  end

  private

  def post_params
    # this will "sanitize" the user input that will be permitted to the DB
    params.require(:post).permit([:title, :body])
  end

  def find_post
    @post = Post.find params[:id]
  end

end # end of class PostsController
