class ClientsController < ApplicationController
  def show
    @client = Client.find(params[:id])
  end

  def index
    @clients = Client.all
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

  def client_params

    params.require(:client).permit(:first_name, :last_name, :email, :phone_number, :company_name, :billing_address)
  end
end
