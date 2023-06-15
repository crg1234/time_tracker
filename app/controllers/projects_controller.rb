class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @clients = Client.all
  end

  def create
    @project = Project.new(project_params)
    @project.client = Client.find(params[:client_id])
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    @task = Task.new
    @tasks = @project.tasks
    @invoices = @project.invoices
    @client = @project.client
    @invoice = @project.invoices.last
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :client_id)
  end
end
