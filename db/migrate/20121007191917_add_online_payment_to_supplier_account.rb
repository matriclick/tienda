class AddOnlinePaymentToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :online_payment, :boolean
  end
end
