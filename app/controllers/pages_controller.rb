class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @clients = current_user.clients
    @projects = current_user.projects
    @invoices = current_user.invoices
    puts @clients
  end
end
