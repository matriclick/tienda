class AddMailSentToSupplierAccounts < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :mail_sent, :boolean, :default => false
  end
end
