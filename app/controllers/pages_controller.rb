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

    @total_billing_amount = 0

    @invoices.each do |invoice|
      @total_billing_amount += invoice.billing_amount
    end
  end

  def learning
  end
end
