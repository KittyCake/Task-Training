class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(name: params[:session][:name])
    if @user && @user.password == params[:session][:password]
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      flash[:notice] = "#{t "messages.false-login"}"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end
