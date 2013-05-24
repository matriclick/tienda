class CreateSupplierWithoutAccounts < ActiveRecord::Migration
  def change
    unless SupplierWithoutAccount.table_exists?
      create_table :supplier_without_accounts do |t|
        t.string :corporate_name
        t.string :web_page
        t.string :fantasy_name
        t.string :phone_number
        t.string :address
        t.integer :industry_category_id

        t.timestamps
      end
    end
  end
end
