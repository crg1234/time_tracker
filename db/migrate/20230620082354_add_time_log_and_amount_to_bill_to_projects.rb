class AddTimeLogAndAmountToBillToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :total_time_log, :integer, default: 0
    add_column :projects, :total_amount_to_bill, :float, default: 0.0
  end
end
