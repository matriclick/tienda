class CreateSupplierPageViews < ActiveRecord::Migration
  def change
    create_table :supplier_page_views do |t|
      t.integer :supplier_account_id
			t.integer :count
			t.string :ip

      t.timestamps
    end
  end
end
