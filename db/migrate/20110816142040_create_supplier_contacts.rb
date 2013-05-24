class CreateSupplierContacts < ActiveRecord::Migration
  def change
    create_table :supplier_contacts do |t|
      t.string :name
			t.string :email
			t.integer :phone_number
			t.integer :contact_type_id
      t.integer :supplier_id

      t.timestamps
    end
  end
end
