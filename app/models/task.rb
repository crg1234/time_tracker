class Task < ApplicationRecord
  belongs_to :project
  validates :title, presence: true
  validates :description, presence: true
  validates :billing_rate, presence: true
end
