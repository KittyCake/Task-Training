class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_task, only: [ :edit, :update, :destroy]
  def index
    # @tasks = Task.all.order('created_at DESC')
    # byebug
    if params[:search]
      @tasks = Task.where("LOWER(title) LIKE LOWER('%#{params[:search]}%') OR LOWER(content) LIKE LOWER('%#{params[:search]}%')")
    elsif params[:task]
      @tasks = Task.where(status: params[:task][:status])
      # byebug
    else
      @tasks = Task.all.order(sort_column + ' ' + sort_direction)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "#{t "messages.done-new"} #{@task.title}"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "#{t "messages.done-edit"} #{@task.title}"
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy!
    flash[:notice] = "#{t "messages.done-delete"} #{@task.title}"
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :priority, :endtime, :status, :tags, :user_id, :search)
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end
