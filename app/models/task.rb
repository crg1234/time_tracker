require "openai"

class Task < ApplicationRecord
  belongs_to :project
  validates :title, presence: true
  # validates :description, presence: true
  validates :billing_rate, presence: true


  def hint
    return read_attribute(:hint) if read_attribute(:hint).present?

    client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"] )
    system_msg = "You are a helpful assistant"
    question = "Please give me a tip of maximum 30 words about how to do #{title} more efficiently"

     begin
      response = client.chat.completions.create(
          model: "gpt-3.5-turbo", # Required.
          messages: [
            { role: "system", content: system_msg },
            { role: "user", content: question }
          ], # Required.
          temperature: 0.7,
          max_tokens: 150,
        )

        if response["error"]
          Rails.logger.error "OpenAI Error: #{response["error"]["message"]}"
          return "Currently unable to generate a hint. Please try again later."
        end

      # response.dig("choices", 0, "message", "content")

      new_hint = response.dig("choices", 0, "message", "content")
      update_columns(hint: new_hint) if new_hint.present?
      return new_hint
      rescue => e
        Rails.logger.error "OpenAI API Error: #{e.message}"
        "Error retrieving hint: #{e.message}"
    end
  end

  def image_url
    self.update_columns(image_url: "https://placehold.co/256x256")
    # if read_attribute(:image_url).present?
    #   return read_attribute(:image_url)
    # else
    #   # client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"] )
    #   # response = client.images.generate(parameters: { prompt: "Black and White Photograph of Brad Pitt doing #{title} without words or letters", size: "256x256" })
    #   # new_image_url = response.dig("data", 0, "url")
    #   # self.update_columns(image_url: new_image_url)
    #   # return new_image_url

    #   # self.update_columns(image_url: "https://placehold.co/256x256")
    # end
  end
end
