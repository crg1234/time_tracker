require 'openai'

OpenAI.configure do |config|
  config.access_token = ENV['OPENAI_ACCESS_TOKEN'] # Ensure this environment variable is set in your .env file
end
