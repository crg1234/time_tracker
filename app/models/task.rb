require "openai"

class Task < ApplicationRecord
  belongs_to :project
  validates :title, presence: true
  # validates :description, presence: true
  validates :billing_rate, presence: true


  def hint
    if read_attribute(:hint).present?
      return read_attribute(:hint)
    else
      client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"] )
      system_msg = "You are a helpful assistant"
      question = "Please give me a tip of maximum 50 words about how to do #{title} more efficiently"

      response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo-16k", # Required.
            messages: [
              { role: "system", content: system_msg },
              { role: "user", content: question }
            ], # Required.
            temperature: 0.7,
            max_tokens: 2000,
        })

      # response.dig("choices", 0, "message", "content")

      new_hint = response.dig("choices", 0, "message", "content")
      self.update_columns(hint: new_hint)
      return new_hint
    end
  end

  def image_url
    if read_attribute(:image_url).present?
      return read_attribute(:image_url)
    else
      client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"] )
      response = client.images.generate(parameters: { prompt: "Black and White Photograph of Brad Pitt doing #{title} without words or letters", size: "256x256" })
      new_image_url = response.dig("data", 0, "url")
      self.update_columns(image_url: new_image_url)
      return new_image_url
    end
  end
end
