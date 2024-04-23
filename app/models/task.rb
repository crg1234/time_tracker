require 'openai'

class Task < ApplicationRecord
  belongs_to :project
  validates :title, presence: true
  validates :billing_rate, presence: true

  def hint
    return read_attribute(:hint) if read_attribute(:hint).present?

    client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])
    system_msg = "You are a helpful assistant"
    question = "Please give me a tip of maximum 30 words about how to do #{title} more efficiently"

    begin
      response = client.completions.create(
        model: "text-davinci-003",  # Make sure this model is correct and available in your plan
        prompt: "#{system_msg}\n#{question}",
        temperature: 0.7,
        max_tokens: 150
      )

      if response.error
        Rails.logger.error "OpenAI API Error: #{response.error['message']}"
        return "Error retrieving hint: Please try again later."
      end

      new_hint = response.choices.first['text'].strip if response.choices.first.present?
      update(hint: new_hint) if new_hint
      new_hint
    rescue => e
      Rails.logger.error "Exception when calling OpenAI API: #{e.message}"
      "Error retrieving hint: #{e.message}"
    end
  end
end
