class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.float :billing_rate
      t.time :start_time
      t.time :end_time
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
