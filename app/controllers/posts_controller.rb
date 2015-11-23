class PostsController < ApplicationController

  # authenticate user
  before_action(:authenticate_user, {except: [:index, :show]})

  # get existing post base on :id, done before action controller method is performed
  before_action(:find_post, {only: [:edit, :update, :show, :destroy]})

  # this will add permission checking if user has the ability to perform actions
  # see private method
  # note: always do this after params getting because it will give access denied error
  # because @post will be always nil
  before_action(:authorize, {only: [:edit, :update, :destroy]})
  # this is the controller for the index page which will show all the blog post
  def index
    if(params[:tag])
      # this will handle the tag links search
      posts = Post.order(updated_at: :desc).search(params[:tag])
    else
      # the query will be used for the search functionality, the search method
      # is defined in the post model
      @query    = params[:query]
      posts = Post.order(updated_at: :desc).search(params[:query])
    end

    set = Set.new(posts)
    @posts = set.to_a

    # for side_bar display variables
    @categories = Category.all
    @favourites = Favourite.where(user: current_user)
  end

  # this is the controller for the add new blog post found in nav bag
  def new
    @post = Post.new
    @category_options = Category.all.map{|u| [u.title, u.id]}
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
    @category_options = Category.all.map{|u| [u.title, u.id]}
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
    # for side_bar display variables
    @favourites = Favourite.where(user: current_user)
  end

  private

  def post_params
    # this will "sanitize" the user input that will be permitted to the DB
    params.require(:post).permit([:title, :body, :user_id,
                                  :category_id, :all_tags])
  end

  def find_post
    @post = Post.find params[:id]
  end

  def authorize
    redirect_to root_path, alert: "Access denied!" unless can? :manage, @post
  end

end # end of class PostsController
