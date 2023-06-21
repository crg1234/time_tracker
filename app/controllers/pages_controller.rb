class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
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

  def learning
  end
end




def total_time_amount
    total_time_on_invoice = 0
    self.project.tasks.each do |task|
      if task.time_log.nil?
        total_time_on_invoice
      else
        total_time_on_invoice += task.time_log
      end
    end
    return total_time_on_invoice
end
