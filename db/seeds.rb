require 'json'
require "openai"

OPENAI_API_KEY = ENV['OPENAI_API_KEY']

# TO CREATE NEW TIME TRACKER USERS - THE PEOPLE WHO LOGIN TO THE APP

client = OpenAI::Client.new(access_token: OPENAI_API_KEY)
system_msg = "You are an api that only returns JSON objects. You do not speak natural language.

 All the results you return will imitate famous people from the business world in the following structure:
  [
   {
    'first_name': 'Christopher',
    'last_name': 'Grant',
    'email': 'chris@gmail.com'
   },
   ...
  ]"
question = "Give me 5 imaginary names famous business people"

response = client.chat(
  parameters: {
    model: "gpt-3.5-turbo", # Required.
    messages: [
      { role: "system", content: system_msg },
      { role: "user", content: question }
      ], # Required.
    temperature: 0.7
  }
)

json_array = response.dig("choices", 0, "message", "content")
time_tracker_user_results = JSON.parse(json_array)

time_tracker_user_results.each do |user|
  User.create!(first_name: user["first_name"], last_name: user["last_name"], email: user["email"])
end
