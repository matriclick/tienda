class CreateSupplierAccountTypes < ActiveRecord::Migration
  def change
    create_table :supplier_account_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
