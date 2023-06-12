class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.integer :invoice_number
      t.float :billing_amount
      t.date :payment_deadline
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
