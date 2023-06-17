class InvoiceMailer < ApplicationMailer
  def new_invoice_email
    @invoice = params[:invoice]
    # @project = @invoice.project
    # @tasks = @project.tasks
    # @client = @project.client
    @user = current_user

    mail(to: @invoice.project.client.email, subject: "You have new invoice from #{@user}")
  end
end
