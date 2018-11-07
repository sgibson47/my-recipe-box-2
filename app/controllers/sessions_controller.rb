class SessionsController < ApplicationController
  before_action :redirect_if_not_logged_in, only: [:destroy]
  before_action :redirect_if_logged_in, only: [:new, :create]
  
  def new
  end

  def create
    if params["code"]
      @user = User.find_or_create_by(email: auth['info']['email']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        u.password = SecureRandom.urlsafe_base64
      end
      session[:user_id] = @user.id
      redirect_to @user
    else
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to @user
      else
        flash[:message] = "Invalid email and password combination."
        redirect_to '/signin'
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end