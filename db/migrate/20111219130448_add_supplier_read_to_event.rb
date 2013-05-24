class AddSupplierReadToEvent < ActiveRecord::Migration
  def change
    add_column :events, :supplier_read, :boolean
    rename_column :events, :read, :user_read
  end
end
