class CreateReferenceRequests < ActiveRecord::Migration
  def change
    create_table :reference_requests do |t|
      t.integer :service_id
      t.integer :product_id
      t.integer :user_account_id
      t.integer :supplier_account_id
      t.text :content

      t.timestamps
    end
  end
end
