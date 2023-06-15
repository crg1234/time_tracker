class Client < ApplicationRecord
  belongs_to :user
  has_many :projects, dependent: :destroy

  validates :first_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name }

  validates :last_name, presence: true
  validates :last_name, uniqueness: { scope: :first_name }

  validates :phone_number, presence: true
  # validates :phone_number, numericality: true
  # validates :phone_number, length: { minimum: 10, maximum: 15 }

  validates :email, presence: true
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }

  validates :billing_address, presence: true
end
