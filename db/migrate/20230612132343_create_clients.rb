class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :company_name
      t.string :billing_address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
