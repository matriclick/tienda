class AddBookableToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :bookable, :boolean, :default => true
  end
end
