class Client < ApplicationRecord
  belongs_to :user
  has_many :projects

  validates :first_name, presence: true
            :uniqueness => { scope: :last_name }

  validates :last_name, presence: true
            :uniqueness => { scope: :first_name }

  validates :phone, :presence => true,
                    :numericality => true,
                    :length => { :minimum => 10, :maximum => 15 }

  validates :email, :presence => true,
                    :uniqueness => true,
                    :format => { :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }

  validates :address, :presence => true





end
