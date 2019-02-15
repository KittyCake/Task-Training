class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_task, only: [ :edit, :update, :destroy]
  before_action :current_tasks, only: [ :index ]
  def index
    # @tasks = Task.all.order('created_at DESC')
    # byebug
    if current_user.nil?
      redirect_to login_path
    elsif params[:tags]
      @tasks = @tasks.tagged_with(params[:tags]).page(params[:page])
    elsif params[:search]
      # @tasks = @tasks.tagged_with(params[:search]).page(params[:page])
      @tasks = @tasks.where("LOWER(title) LIKE LOWER('%#{params[:search]}%') OR LOWER(content) LIKE LOWER('%#{params[:search]}%')").page(params[:page])
      # byebug
    elsif params[:task]
      @tasks = @tasks.where(status: params[:task][:status]).page(params[:page])
      # byebug
    else
      @tasks = @tasks.all.order(sort_column + ' ' + sort_direction).page(params[:page])
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

  def current_tasks
    @tasks = User.find(current_user.id).tasks
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
