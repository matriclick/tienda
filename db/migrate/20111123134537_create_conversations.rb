class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :user_account_id
      t.integer :supplier_account_id
      t.integer :product_id
      t.integer :service_id
      t.string :title

      t.timestamps
    end
  end
end
