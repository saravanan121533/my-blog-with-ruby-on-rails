class PostsController < ApplicationController

  # authenticate user
  before_action(:authenticate_user, {except: [:index, :show]})

  # this will add permission checking if user has the ability to perform actions
  # see private method
  # before_action(:authorize, {only: [:edit, :update, :destroy]})

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
    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  # controller for the edit page when the edit icon is clicked at show page
  # actual processing will be done at update method
  def edit
    # checking if the user has the ability to modify if not error
    # redirect_to root_path, alert: "Access denied." unless can? :edit, @post
  end

  # this is the post method for edit a blog post this will be called after the
  # "Update Post" is clicked in edit page
  def update
    # get user input through params for this specific blog post
    if @post.update(post_params)
      # if update is successful show page will be displayed reflecting changes
      redirect_to post_path(@post)
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
    params.require(:post).permit([:title, :body, :user_id])
  end

  def find_post
    @post = Post.find params[:id]
  end

  def authorize
    redirect_to root_path, alert: "Access denied!" unless can? :manage, @post
  end

end # end of class PostsController
