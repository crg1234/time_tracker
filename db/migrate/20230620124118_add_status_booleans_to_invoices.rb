class AddStatusBooleansToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :status, :boolean, default: false
    add_column :invoices, :invoice_sent, :boolean, default: false
  end
end
