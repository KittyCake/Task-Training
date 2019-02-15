class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_task, only: [ :edit, :update, :destroy]
  def index
    # @tasks = Task.all.order('created_at DESC')
    # byebug
    if current_user.nil?
      redirect_to login_path
    elsif params[:search]
      @tasks = User.find(current_user.id).tasks.where("LOWER(title) LIKE LOWER('%#{params[:search]}%') OR LOWER(content) LIKE LOWER('%#{params[:search]}%')").page(params[:page])
    elsif params[:task]
      @tasks = User.find(current_user.id).tasks.where(status: params[:task][:status]).page(params[:page])
      # byebug
    else
      @tasks = User.find(current_user.id).tasks.all.order(sort_column + ' ' + sort_direction).page(params[:page])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      flash[:notice] = "#{t "messages.done-new"} #{@task.title}"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "#{t "messages.done-edit"} #{@task.title}"
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy!
    flash[:notice] = "#{t "messages.done-delete"} #{@task.title}"
    redirect_to root_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :priority, :endtime, :status, :tags, :search, :tag_list)
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end
