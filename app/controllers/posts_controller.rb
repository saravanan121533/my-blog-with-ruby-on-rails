class PostsController < ApplicationController

  before_action(:authenticate_user, {except: [:index, :show]})
  before_action(:find_post, {only: [:edit, :update, :show, :destroy]})
  before_action(:authorize, {only: [:edit, :update, :destroy]})

  def index
    PostCleanupJob.perform_later
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
    @categories = Category.all
    @favourites = Favourite.where(user: current_user)
  end

  def new
    @post = Post.new
    @category_options = Category.all.map{|u| [u.title, u.id]}
  end

  def create
    @category_options = Category.all.map{|u| [u.title, u.id]}
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @category_options = Category.all.map{|u| [u.title, u.id]}
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def show
    @comment = Comment.new
    @favourites = Favourite.where(user: current_user)
  end

  private

  def post_params
    params.require(:post).permit([:title, :body, :user_id,
                                  :category_id, :all_tags, :image])
  end

  def find_post
    @post = Post.find params[:id]
  end

  def authorize
    redirect_to root_path, alert: "Access denied!" unless can? :manage, @post
  end

end
