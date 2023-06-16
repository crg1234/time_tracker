require 'open-uri'
require 'json'
require 'faker'


puts "Cleaning up database..."
Invoice.destroy_all
Task.destroy_all
Project.destroy_all
Client.destroy_all
User.destroy_all

puts "Database cleaned"

juliette_file = URI.open("https://avatars.githubusercontent.com/u/131234422?v=4")
juliette = User.create(email: "great.time@gmail.com", password: "secret", first_name: "Juliette", last_name: "Guillaume")
juliette.photo.attach(io: juliette_file, filename: "juliette.jpg", content_type: "image/png")
juliette.save

tom_file = URI.open("https://avatars.githubusercontent.com/u/131278560?v=4")
tom = User.create(email: "peewie@gmail.com", password: "secret", first_name: "Tom", last_name: "Dennis")
tom.photo.attach(io: tom_file, filename: "tom.png", content_type: "image/png")
tom.save

chris_file = URI.open("https://avatars.githubusercontent.com/u/6758646?v=4")
chris = User.create(email: "showmustgoon@gmail.com", password: "secret", first_name: "Chris", last_name: "Grant")
chris.photo.attach(io: chris_file, filename: "chris.png", content_type: "image/png")
chris.save

safia_file = URI.open("https://avatars.githubusercontent.com/u/122315676?v=4")
safia = User.create(email: "good.day@gmail.com", password: "secret", first_name: "Safia", last_name: "Raza")
safia.photo.attach(io: safia_file, filename: "safia.png", content_type: "image/png")
safia.save

nurra_file = URI.open("https://avatars.githubusercontent.com/u/110908022?v=4")
nurra = User.create(email: "happy.tracker@gmail.com", password: "secret", first_name:"Nurra", last_name: "Barry")
nurra.photo.attach(io: nurra_file, filename: "nurra.png", content_type: "image/png")
nurra.save

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


num_dummy_tasks = 70
tasks = []
start_time_defined = 0
url = "https://dummyjson.com/todos"
user_serialized = URI.open(url).read
user_json = JSON.parse(user_serialized)

num_dummy_tasks.times do
  tasks << Task.create!(
    title: user_json["todos"].sample["todo"],
    description: "Done",
    billing_rate: rand(1.1..100.9),
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
