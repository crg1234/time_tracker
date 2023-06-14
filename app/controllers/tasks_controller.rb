class TasksController < ApplicationController

  def show
    @task = Task.find(params[:id])
    @amount_to_bill = @task.billing_rate * (@task.time_log / 3_600_000) # to convert milliseconds to hours
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

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    head :no_content
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :billing_rate, :start_time, :end_time, :time_log)
  end
end
