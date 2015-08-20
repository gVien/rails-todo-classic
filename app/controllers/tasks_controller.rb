class TasksController < ApplicationController
  def index
    @tasks = Task.all.order("id ASC")
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path
    else
      render "new"
    end
  end

  def update
    @task = Task.find(params[:id])

    @task.assign_attributes(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render "edit"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to tasks_path
  end

  def complete
    task = Task.find(params[:id])
    if task.complete == false
      task.complete = true
      task.save
      redirect_to tasks_path
    else
      task.complete = false
      task.save
      redirect_to tasks_path
    end
  end

  private
  def task_params
    params.require(:task).permit(:task)
  end
end
