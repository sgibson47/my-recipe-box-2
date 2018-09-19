class SessionsController < ApplicationController
  before_action :redirect_if_not_logged_in, only: [:destroy]
  before_action :redirect_if_logged_in, only: [:new, :create]
  
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:message] = "Invalid email and password combination."
      redirect_to '/signin'
    end
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end
end