class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :clients
  has_many :projects, through: :clients
  has_many :invoices, through: :projects
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_one_attached :photo
end
