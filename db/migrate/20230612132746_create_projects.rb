class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.date :deadline
      t.float :time_counter
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
