class AddIsSupplierToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :is_supplier, :boolean
  end
end
