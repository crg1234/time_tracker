class ClientsController < ApplicationController
  def show
    @client = Client.find(params[:id])
    @project = Project.new
    @projects = @client.projects
  end

  def index
    @clients = Client.all
    @client = Client.new
    @clients = current_user.clients
    @projects = current_user.projects
    @invoices = current_user.invoices
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.user = current_user
    if @client.save
      redirect_to client_path(@client)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      redirect_to client_path(@client)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy!
    redirect_to dashboard_path, notice: 'Client was successfully deleted.'
  end

  def client_params

    params.require(:client).permit(:first_name, :last_name, :email, :phone_number, :company_name, :billing_address, :project_id)
  end
end
