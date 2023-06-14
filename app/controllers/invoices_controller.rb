class InvoicesController < ApplicationController

  def show
    @invoice = Invoice.find(params[:id])
    @project = @invoice.project
    @tasks = @project.tasks
    @client = @project.client
    @user = current_user
  end

  def new
    @project = Project.find(params[:project_id])
    @invoice = Invoice.new
  end

  def create
    @project = Project.find(params[:project_id])
    @invoice = Invoice.new(invoice_params)
    @invoice.project = @project
    if @invoice.save
      redirect_to project_path(@project)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def invoice_params
    params.require(:invoice).permit(:invoice_number, :billing_amount, :payment_deadline)
  end

end
