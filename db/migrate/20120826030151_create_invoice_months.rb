class CreateInvoiceMonths < ActiveRecord::Migration
  def change
    create_table :invoice_months do |t|
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
