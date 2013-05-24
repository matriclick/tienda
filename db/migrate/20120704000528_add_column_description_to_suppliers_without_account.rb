class AddColumnDescriptionToSuppliersWithoutAccount < ActiveRecord::Migration
  def change
    add_column :supplier_without_accounts, :description, :text
    
  end
end
