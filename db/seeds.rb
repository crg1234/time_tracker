require 'faker'

puts "Cleaning up database..."
Invoice.destroy_all
Task.destroy_all
Project.destroy_all
Client.destroy_all
User.destroy_all

puts "Database cleaned"

juliette = User.create!(email: "great.time@gmail.com", password: "secret", first_name: "Juliette", last_name: "Guillaume" )
tom = User.create!(email: "peewie@gmail.com", password: "secret", first_name: "Tom", last_name: "Dennis")
chris = User.create!(email: "showmustgoon@gmail.com", password: "secret", first_name: "Chris", last_name: "Grant")
safia = User.create!(email: "good.day@gmail.com", password: "secret", first_name: "Safia", last_name: "Raza")
nurra = User.create!(email: "happy.tracker@gmail.com", password: "secret", first_name:"Nurra", last_name: "Barry")

puts "Create new database.."

num_dummy_clients = 30
clients = []
users = [juliette, tom, chris, safia, nurra]
num_dummy_clients.times do
  clients << Client.create!(
    first_name:   Faker::Name.first_name,
    last_name:    Faker::Name.unique.last_name,
    email:        Faker::Internet.unique.email,
    phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    company_name: Faker::Company.name,
    billing_address:Faker::Address.full_address,
    user: users.sample
  )
end

num_dummy_projects = 40
projects = []
num_dummy_projects.times do
  projects << Project.create!(
    name:         Faker::Team.name,
    deadline:     Faker::Date.in_date_period,
    time_counter: Faker::Number.decimal(l_digits: 2),
    client: clients.sample
  )
end

num_dummy_tasks = 40
tasks = []
tasks_title = ["Update database", "send a new invoice", "finish the project", "call the supplier"]
billing_rates = [1.5, 2.4, 3.5]
start_time_defined = 0
num_dummy_tasks.times do
  tasks << Task.create!(
    title:           tasks_title.sample,
    description:     "Just do it right",
    billing_rate: billing_rates.sample,
    start_time: Faker::Time.forward(days: 1, period: :morning),
    end_time:   Faker::Time.forward(days: 1, period: :evening),
    project: projects.sample
  )
end

num_dummy_invoices = 80
invoices = []
num_dummy_invoices.times do
  invoices << Invoice.create!(
    invoice_number:  Faker::Number.number(digits: 6),
    billing_amount:  Faker::Number.binary(digits: 3),
    payment_deadline: Faker::Date.in_date_period,
    project: projects.sample
  )
end

puts "Congrats ! You have a new database"
