class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now.alert = "Your user information is not valid"
      render :new
    end

  end

  def index
    @counter=0;
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
