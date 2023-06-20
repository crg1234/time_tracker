class AddBankDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :bank_name, :string
    add_column :users, :bank_account_number, :string
    add_column :users, :bank_iban, :string
  end
end
