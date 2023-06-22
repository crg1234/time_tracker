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

  def index
    @client = Client.new
    @clients = current_user.clients
    @projects = current_user.projects
    @invoices = current_user.invoices

    @my_invoices = Invoice.where(project: current_user.projects)


    # Total billed on dashboard
    @total_billing_amount = 0
    @my_invoices.each do |invoice|
      if invoice.billing_amount.nil?
        @total_billing_amount
      else
        @total_billing_amount += invoice.billing_amount
      end
    end

    # # Payment received on dashboard

    # Total Time Logged on dashboard
    @total_time_logged = 0
    @projects.each do |project|
      if project.total_amount_time.nil?
        @total_time_logged
      else
        @total_time_logged += project.total_amount_time
      end
    end

    # Invoices sent on dashboard
    @invoices_array = []
    @my_invoices.each do |invoice|
      @invoices_array << invoice
    end

    return 0 if @invoices_array.empty?

    @invoices_sent = @invoices_array.length

     # Paid invoices on dashboard
    @paid_invoices_array = []
    @my_invoices.each do |invoice|
      unless invoice.status == false
        @invoices_array << invoice
      end
    end

    @invoices_paid = @paid_invoices_array.length

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
    @invoice.invoice_sent = true
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
