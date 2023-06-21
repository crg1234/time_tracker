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
              #  disposition: :inline,
               layout: 'pdf',
               page_size: 'A4',
               encoding:"UTF-8"
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
      redirect_to invoice_path(@invoice)
      InvoiceMailer.with(invoice: @invoice).new_invoice_email.deliver_later
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update(invoice_params)
    head :no_content
  end

  def update_invoice_sent
    @invoice = Invoice.find(params[:id])
    @invoice.invoice_sent == true
    @invoice.save
  end

  def update_invoice_status
    @invoice = Invoice.find(params[:id])
    @invoice.status = true
    # @invoice.save!
    if @invoice.save
      redirect_to invoice_path(@invoice)
    end
  end
  private

  def invoice_params
    params.require(:invoice).permit(:invoice_number, :billing_amount, :payment_deadline, :project_id, :invoice_sent, :status)
  end

end
