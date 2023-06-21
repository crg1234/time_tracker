require 'open-uri'
require 'json'
require 'faker'
require "csv"



puts "Cleaning up database..."
Invoice.destroy_all
Task.destroy_all
Project.destroy_all
Client.destroy_all
User.destroy_all

puts "Database cleaned"

juliette_file = URI.open("https://avatars.githubusercontent.com/u/131234422?v=4")
juliette = User.create(email: "great.time@gmail.com", password: "secret", first_name: "Juliette", last_name: "Guillaume", bank_name: Faker::Bank.name, bank_account_number: Faker::Bank.account_number, bank_iban: Faker::Bank.iban)
juliette.photo.attach(io: juliette_file, filename: "juliette.jpg", content_type: "image/png")
juliette.save

tom_file = URI.open("https://avatars.githubusercontent.com/u/131278560?v=4")
tom = User.create(email: "peewie@gmail.com", password: "secret", first_name: "Tom", last_name: "Dennis", bank_name: Faker::Bank.name, bank_account_number: Faker::Bank.account_number, bank_iban: Faker::Bank.iban)
tom.photo.attach(io: tom_file, filename: "tom.png", content_type: "image/png")
tom.save

chris_file = URI.open("https://avatars.githubusercontent.com/u/6758646?v=4")
chris = User.create(email: "showmustgoon@gmail.com", password: "secret", first_name: "Chris", last_name: "Grant", bank_name: Faker::Bank.name, bank_account_number: Faker::Bank.account_number, bank_iban: Faker::Bank.iban)
chris.photo.attach(io: chris_file, filename: "chris.png", content_type: "image/png")
chris.save

safia_file = URI.open("https://avatars.githubusercontent.com/u/122315676?v=4")
safia = User.create(email: "good.day@gmail.com", password: "secret", first_name: "Safia", last_name: "Raza", bank_name: Faker::Bank.name, bank_account_number: Faker::Bank.account_number, bank_iban: Faker::Bank.iban)
safia.photo.attach(io: safia_file, filename: "safia.png", content_type: "image/png")
safia.save

nurra_file = URI.open("https://avatars.githubusercontent.com/u/110908022?v=4")
nurra = User.create(email: "happy.tracker@gmail.com", password: "secret", first_name:"Nurra", last_name: "Barry", bank_name: Faker::Bank.name, bank_account_number: Faker::Bank.account_number, bank_iban: Faker::Bank.iban)
nurra.photo.attach(io: nurra_file, filename: "nurra.png", content_type: "image/png")
nurra.save

puts "Create new database.."

num_dummy_clients = 30
clients = []
users = [juliette, tom, chris, safia, nurra]
client_images = ["https://img.freepik.com/free-photo/woman-man-are-laughing-laughing_188544-17096.jpg", "https://img.freepik.com/free-photo/young-adult-businesswoman-smiling-camera-indoors-generated-by-ai_188544-32954.jpg", "https://img.freepik.com/free-photo/smiling-young-adults-enjoy-nightlife-bar-generated-by-ai_188544-23506.jpg","https://img.freepik.com/free-photo/young-adults-enjoy-carefree-autumn-sunset-together-generated-by-ai_188544-33019.jpg", "https://img.freepik.com/free-photo/one-young-adult-woman-smiling-looking-camera-generated-by-ai_188544-26107.jpg", "https://img.freepik.com/premium-photo/generative-ai-portrait-young-asiatic-rebel-pink-hair-woman-looking-camera-serene-confident_108985-1916.jpg", "https://img.freepik.com/free-photo/beautiful-women-with-toothy-smiles-enjoying-nightlife-generated-by-ai_188544-28139.jpg", "https://img.freepik.com/free-photo/one-woman-smiling-autumn-forest-beauty-generated-by-ai_188544-43523.jpg", "https://img.freepik.com/free-photo/active-seniors-enjoy-carefree-summer-vacation-adventure-generated-by-ai_188544-33843.jpg", "https://img.freepik.com/premium-photo/man-with-smile-his-face-smiles-camera_910718-31.jpg", "https://img.freepik.com/premium-photo/man-wearing-gold-medallion-that-says-gold-it_759095-28087.jpg", "https://img.freepik.com/premium-photo/man-solid-color-background-with-smile-facial-expression_781958-2546.jpg", "https://img.freepik.com/free-photo/smiling-couples-hiking-mountain-enjoying-nature-s-adventure-generated-by-ai_188544-33309.jpg", "https://img.freepik.com/free-photo/multi-ethnic-group-friends-smiling-celebration-generated-by-ai_188544-27958.jpg", "https://img.freepik.com/free-photo/man-girl-sit-boat-looking-each-other_188544-20581.jpg", "https://img.freepik.com/free-photo/woman-wearing-glasses-stands-busy-office-with-blurred-background_188544-33150.jpg", "https://img.freepik.com/free-photo/confident-businesswoman-smiling-computer-office-generated-by-ai_188544-22874.jpg", "https://img.freepik.com/free-photo/smiling-businesswoman-coworkers-studying-office-generated-by-ai_188544-33148.jpg", "https://img.freepik.com/free-photo/successful-business-team-smiling-with-confidence-indoors-generated-by-ai_188544-41100.jpg", "https://img.freepik.com/free-photo/man-with-beard-glasses-smiles-camera_188544-29222.jpg", "https://img.freepik.com/free-photo/two-young-adult-females-enjoying-nightlife-together-generated-by-ai_188544-33877.jpg", "https://img.freepik.com/free-photo/smiling-women-performing-ballet-audience-enjoys-performance-generated-by-ai_24640-86811.jpg", "https://img.freepik.com/free-photo/young-adults-smiling-celebrating-traditional-festival-outdoors-generated-by-ai_188544-38416.jpg", "https://img.freepik.com/free-photo/group-cheerful-business-people-talking-generated-by-ai_188544-27426.jpg", "https://img.freepik.com/free-photo/smiling-girl-splashing-water-carefree-summer-fun-generated-by-ai_24640-81589.jpg", "https://img.freepik.com/free-photo/group-friends-enjoying-coffee-leisurely-generated-by-ai_188544-29942.jpg", "https://img.freepik.com/free-photo/beautiful-fashion-model-smiling-outdoors-night-generated-by-ai_188544-40159.jpg", "https://img.freepik.com/free-photo/one-young-woman-sitting-working-laptop-generated-by-ai_188544-22212.jpg", "https://img.freepik.com/free-photo/young-adults-brainstorm-new-business-strategy-indoors-generated-by-ai_188544-29154.jpg", "https://img.freepik.com/free-photo/successful-young-businessman-using-technology-modern-office-generated-by-ai_188544-22877.jpg"]
num_dummy_clients.times do
  clients << Client.create!(
    first_name:   client_first_name = Faker::Name.first_name,
    last_name:    client_last_name = Faker::Name.unique.last_name,
    email:        "#{client_first_name}.#{client_last_name}@gmail.com",
    phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    company_name: Faker::Company.name,
    billing_address:Faker::Address.full_address,
    user: users.sample,
    image_url: client_images.pop
  )
end

filepath = "db/projects-tasks.csv"
projects = []

CSV.foreach(filepath) do |row|
  name = row[0]
  project = Project.new(name: row[0], deadline: Faker::Date.in_date_period, time_counter: Faker::Number.decimal(l_digits: 2),)
  project.client = clients.sample
  p project
  project.save!
  projects << project
  3.times do|n|
    title = row[n]
    task = Task.new(time_log: Faker::Number.between(from: 1000*60*20, to: 1000*60*67), created_at: Faker::Time.backward,title: row[n], description: "Done", billing_rate: rand(550.9..1010.9), start_time: Faker::Time.forward(days: 1, period: :morning), end_time:   Faker::Time.forward(days: 1, period: :evening), project_id:project.id)
    task.project = project
    task.amount_to_bill = task.billing_rate*task.time_log/1000/60/60
    task.save!
  end

end

# num_dummy_projects = 40
# project_array = []
# num_dummy_projects.times do
#   projects << Project.create!(
#     name:         project_array.sample,
#     deadline:     Faker::Date.in_date_period,
#     time_counter: Faker::Number.decimal(l_digits: 2),
#     client: clients.sample
#   )
# end

# num_dummy_tasks = 40
# tasks = []
# # start_time_defined = 0
# url = "https://dummyjson.com/todos"
# task_serialized = URI.open(url).read
# task_json = JSON.parse(task_serialized)

# num_dummy_tasks.times do
#   tasks << Task.create!(
#     title: task_json["todos"].sample["todo"],
#     description: "Done",
#     billing_rate: rand(1.1..100.9),
#     start_time: Faker::Time.forward(days: 1, period: :morning),
#     end_time:   Faker::Time.forward(days: 1, period: :evening),
#     project: projects.sample
#   )
# end

num_dummy_invoices = 80
invoices = []
num_dummy_invoices.times do
  invoices << Invoice.create!(
    invoice_number:  Faker::Number.number(digits: 6),
    billing_amount:  Faker::Number.binary(digits: 5),
    payment_deadline: Faker::Date.in_date_period,
    project: projects.sample
  )
end

puts "Congrats ! You have a new database"
