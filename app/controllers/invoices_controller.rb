class InvoicesController < ApplicationController

  def show
    @invoice = Invoice.find(params[:id])
    @project = @invoice.project
    @tasks = @project.tasks
    @client = @project.client
    @user = current_user

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "My Invoice", # filename
               template: "invoices/show_print_pdf",
               formats: [:html],
               disposition: :inline,
               layout: 'pdf'
      end
    end
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
    params.require(:invoice).permit(:invoice_number, :billing_amount, :payment_deadline, :project_id)
  end

end
