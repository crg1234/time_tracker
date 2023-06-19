class Project < ApplicationRecord
  belongs_to :client
  has_many :invoices
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
  validates :deadline, presence: true
end
