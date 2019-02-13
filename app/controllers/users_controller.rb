class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :showtasks]

  def index
    if current_user.admin?
      @users = User.all.page(params[:page])
    else
      flash[:notice] = "#{t "messages.not-admin"}"
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "#{t "messages.new-user"} #{@user.name}"
      redirect_to users_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "#{t "messages.done-edit"} #{@user.name}"
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = "#{t "messages.done-delete"} #{@user.name}"
    else
      flash[:notice] = "#{t "messages.last-admin"}"
    end

    # @user.save!
    redirect_to users_path
  end

  def showtasks
    @tasks = @user.tasks.page(params[:page])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password, :admin)
  end
end
