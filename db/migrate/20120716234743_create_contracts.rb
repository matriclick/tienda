class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :supplier_account_id
      t.string :contract_number
      t.string :contract_type
      t.date :signature_date
      t.string :invoice_rut
      t.float :price
      t.float :commision
      t.date :not_invoice_until
      t.text :comments

      t.timestamps
    end
  end
end
