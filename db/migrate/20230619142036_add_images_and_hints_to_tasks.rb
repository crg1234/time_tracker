class AddImagesAndHintsToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :image_url, :string
    add_column :tasks, :hint, :string
  end
end
