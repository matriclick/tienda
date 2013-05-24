class CreateTableForRelatingInvoicesWithMonths < ActiveRecord::Migration
  def up
    create_table :invoices_invoice_months, :id => false do |t|
       t.integer :invoice_id
       t.text :invoice_month_id

       t.timestamps
     end
  end

  def down
  end
end
