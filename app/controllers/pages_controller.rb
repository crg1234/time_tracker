class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @client = Client.new
    @clients = current_user.clients
    @projects = current_user.projects
    @my_invoices = Invoice.where(project: current_user.projects)
  end
end
