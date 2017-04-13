class SessionsController < ApplicationController
  def new
    render "new.html.erb"
  end
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully Logged In!"
      redirect_to "/articles"
    else
      flash[:warning] = "Invalid email or password!"
      redirect_to "/login"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully Logged Out!"
    redirect_to "/articles"
  end
end
