class Client < ApplicationRecord
  belongs_to :user
  has_many :projects

  validates :first_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name }

  validates :last_name, presence: true
  validates :last_name, uniqueness: { scope: :first_name }

  validates :phone, presence: true
  validates :phone, numericality: true
  validates :phone, length: { minimum: 10, maximum: 15 }

  validates :email, presence: true
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }

  validates :address, presence: true
end
