class AddSupplierIdToReferenceRequest < ActiveRecord::Migration
  def change
    add_column :reference_requests, :supplier_id, :integer
  end
end
