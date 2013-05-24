class CreateSupplierAccounts < ActiveRecord::Migration
  def change
    create_table :supplier_accounts do |t|
      t.integer :supplier_id
			t.string  :email
	    t.string  :corporate_name
	    t.string  :web_page
	    t.string  :fantasy_name
	    t.string  :rut
	    t.integer :phone_number
	    t.string  :address
	    t.string  :image_file_name
	    t.string  :image_content_type
	    t.integer :image_file_size
	    t.datetime :image_updated_at
      t.timestamps
    end
  end
end
