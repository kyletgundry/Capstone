class UsersController < ApplicationController

  def new
    render "new.html.erb"
  end

  def create
    user = User.new(
      first_name: params["first_name"],
      last_name: params["last_name"],
      image: params["image"],
      email: params["email"],
      phone_number: params["phone_number"]
      )
    if user.save
      session[:user_id] = user.id
      flash[:success] = 'Successfully created account!'
      redirect_to "/"
    else
      flash[:warning] = 'Invalid email or password!'
      redirect_to "/signup"
    end
  end

end
