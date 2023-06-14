class AddColumnToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :time_log, :integer, default: 0
  end
end
