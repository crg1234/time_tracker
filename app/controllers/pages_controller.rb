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
    # @total_billing_amount = 0
    # @my_invoices.each do |invoice|
    #   @total_billing_amount += invoice.billing_amount
    # end

    # Payment received on dashboard

    # # Total Time Logged on dashboard
    # @total_time_logged = 0
    # @projects.each do |project|
    #   @total_time_logged += project.total_amount_time
    # end

    # Invoices sent on dashboard
    @invoices_array = []
    @my_invoices.each do |invoice|
      @invoices_array << invoice
    end

    @count_invoices = @invoices_array.length

  end

  def learning
  end
end
