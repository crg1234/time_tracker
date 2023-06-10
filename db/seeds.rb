require 'json'
require "openai"

client = OpenAI::Client.new(access_token: OPENAI_API_KEY)
# system_msg = "You are an api that only returns JSON objects. You do not speak natural language.

#               Specifically, you are an api similar to google maps and you return places based on the user input.

#               All the places you return will be in the following structure:
#               [
#               {
#               'name': 'Farm & Co Kingscliff',
#               'address': '529 cudgen road, cudgen, nsw 2487 Australia'
#               },
#               ...
#               ]"
# question = "Give me 3 restaurants in Sydney"

# response = client.chat(
#   parameters: {
#       model: "gpt-4", # Required.
#       messages: [
#         { role: "system", content: system_msg },
#         { role: "user", content: question }
#       ], # Required.
#       temperature: 0.7,
#   })

# json_array = response.dig("choices", 0, "message", "content")
# rest_results = JSON.parse(json_array)

# rest_results.each do |rest|
#   Restaurant.create!(name: rest["name"], address: rest["address"])
# end
