class TasksController < ApplicationController

  def show
    @task = Task.find(params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.create(task_params)
    redirect_to project_path(@project)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :billing_rate, :start_time, :end_time)
  end
end
