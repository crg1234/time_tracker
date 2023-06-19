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
    @task = @project.tasks.new(task_params)
    @task.image_url = "https://placehold.co/256x256"
    @task.save
    redirect_to project_path(@project)
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    head :no_content
  end


  private

  def task_params
    params.require(:task).permit(:title, :description, :billing_rate, :start_time, :end_time, :time_log, :amount_to_bill, :completed, :image_url, :hint)
  end
end
