class AddSupplierIdToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :supplier_id, :integer
  end
end
