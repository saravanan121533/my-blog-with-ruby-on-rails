class PostsController < ApplicationController
  def index
    @posts = Post.all.order(updated_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    redirect_to posts_path
  end

  def show
    @post = Post.find params[:id]
  end



  private

  # this will "sanitize" the user input that will be permitted to the DB
  def post_params
    params.require(:post).permit([:title, :body])
 end
end # end of class PostsController
