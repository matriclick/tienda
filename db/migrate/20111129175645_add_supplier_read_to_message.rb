class AddSupplierReadToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :supplier_read, :boolean
  end
end
