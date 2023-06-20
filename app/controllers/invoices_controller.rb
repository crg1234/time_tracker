class InvoicesController < ApplicationController

  def show
    @invoice = Invoice.find(params[:id])
    @project = @invoice.project
    @tasks = @project.tasks
    @client = @project.client
    @user = current_user

    @tasks.each do |task|
      @invoice.billing_amount = 0
      if task.amount_to_bill.nil?
        @invoice.billing_amount
      else
        @invoice.billing_amount += task.amount_to_bill
      end

      @total_time_on_invoice = 0
      if task.time_log.nil?
        @total_time_on_invoice
      else
       @total_time_on_invoice += task.time_log
      end
    end

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

  def invoice_params
    params.require(:invoice).permit(:invoice_number, :billing_amount, :payment_deadline, :project_id)
  end

end
