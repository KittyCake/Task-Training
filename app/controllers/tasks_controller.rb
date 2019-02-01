class TasksController < ApplicationController
  before_action :set_task, only: [ :edit, :update, :destroy]
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = '新增成功'
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = '修改成功'
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy!
    flash[:notice] = '刪除成功'
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :priority, :endtime, :status, :tags, :user_id)
  end
end
