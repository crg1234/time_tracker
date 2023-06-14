class ClientsController < ApplicationController
  def show
    @client = Client.find(params[:id])
  end

  def index
    @clients = Client.all
  end


  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  def create
    # @client = Client.find(params[:client_id]) MUST find a way to check if existing
    @client = @client.create(client_params)
    redirect_to client_path(@client)
  end

  private

  def task_params
    params.require(:client).permit(:company_name, :first_name, :last_name, :email, :phone_number, :billing_address)
  end
  end
