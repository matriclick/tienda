class AddDescriptionToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :description, :text
  end
end
