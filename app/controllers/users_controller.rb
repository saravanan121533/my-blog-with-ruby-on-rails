class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # get user input
    user_params = params.require(:user).permit(:first_name, :last_name, :email,
                                     :password, :password_confirmation)
    # create new variable and initialize it with the user input
    @user = User.new(user_params)

    # check if successful db query or not
    if @user.save
      # successful user registration
      session[:user_id] = @user.id
      redirect_to root_path, notice: "account created!"
    else
      render :new
    end
  end
end
