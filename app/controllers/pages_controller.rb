class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @clients = current_user.clients
    @projects = current_user.projects
<<<<<<< HEAD
    @my_invoices = Invoice.where(project: current_user.projects)
=======
    @invoices = current_user.invoices
    puts @clients
>>>>>>> e3baf0ca692f51ea30aa0587286c640339a36da1
  end
end
