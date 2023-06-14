class AddBillingColumnToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :amount_to_bill, :float
  end
end
