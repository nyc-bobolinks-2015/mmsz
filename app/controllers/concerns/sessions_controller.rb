class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now.alert = 'You have entered an incorrect username or password'
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
