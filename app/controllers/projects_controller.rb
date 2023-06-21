class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @clients = Client.all
  end

  def create
    @project = Project.new(project_params)
    @project.client = Client.find(params[:client_id])
    if @project.save
      redirect_to project_path(@project)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @project = Project.find(params[:id])
    @task = Task.new
    @tasks = @project.tasks
    @invoices = @project.invoices
    @client = @project.client
    @latest_invoice = @project.invoices.last
    @invoice = Invoice.new
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

  private

  def project_params
    params.require(:project).permit(:name, :description, :client_id, :deadline)
  end
end
