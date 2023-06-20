class Project < ApplicationRecord
  belongs_to :client
  has_many :invoices, dependent: :destroy
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
  validates :deadline, presence: true

  def total_amount_bill
    self.tasks.each do |task|
      total_amount_to_bill = 0
      if task.amount_to_bill.nil?
        total_amount_to_bill
      else
        total_amount_to_bill += task.amount_to_bill
        return total_amount_to_bill
      end
    end
  end

  def total_amount_time
    self.tasks.each do |task|
    total_time_log = 0
      if task.time_log.nil?
        total_time_log
      else
        total_time_log += task.time_log
        return total_time_log
      end
    end
  end
end
