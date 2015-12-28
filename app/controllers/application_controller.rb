class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include CanCan::ControllerAdditions

  def get_categories
    @sd_categories = Category.all
  end
  helper_method :get_categories

  def get_category_post_count(cat)
    @sd_posts = Post.where(category_id: cat).count
  end
  helper_method :get_category_post_count

  def authenticate_user
    redirect_to new_session_path, alert: "Please sign in!" unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find_by_id session[:user_id] if session[:user_id]
  end
  helper_method :current_user

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

end
