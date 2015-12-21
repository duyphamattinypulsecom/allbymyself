class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(:email => params[:user][:email])

    if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to root_path
    else
        @user ||= User.new
        @user.errors.add(:base, "Invalid username or password")
        render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
