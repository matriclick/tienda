class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :contract_id
      t.date :issued_date
      t.integer :number
      t.float :net_price
      t.float :vat
      t.boolean :payed
      t.date :pay_date
      t.text :comments

      t.timestamps
    end
  end
end
