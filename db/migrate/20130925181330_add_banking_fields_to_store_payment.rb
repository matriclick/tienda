class AddBankingFieldsToStorePayment < ActiveRecord::Migration
  def change
    add_column :store_payments, :rut, :string
    add_column :store_payments, :account_owner_name, :string
    add_column :store_payments, :account_owner_email, :string
    add_column :store_payments, :account_bank, :string
    add_column :store_payments, :account_number, :string
    add_column :store_payments, :account_type, :string
  end
end
