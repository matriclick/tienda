class AddSupplierIdToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :supplier_id, :integer
  end
end
