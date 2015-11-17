class SessionsController < ApplicationController
  def new
    # this will be initiated when a user Log-in and calls users/new.html.erb
    @user = User.new
  end

  def create
    # assign user local variable as the User data based on the email params
    user = User.find_by_email params[:email]

    # check if user password match in the existing User data
    if user && user.authenticate(params[:password])
      # add user session for access and permission in the app
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged In!"
    else
      # meaning the user input the wrong Log-in info
      flash[:alert] = "Wrong credentials!"
      render :new
    end # end of if-else statement
  end # end of create method

  def destroy
    # once user clicks Log-out this will delete the user_id in the session to
    # discontinue user access and permission
    session[:user_id] = nil
    redirect_to root_path, notice: "Successful Log-out."
  end

end
