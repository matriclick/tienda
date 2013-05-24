class CreateGiftCards < ActiveRecord::Migration
  def change
    create_table :gift_cards do |t|
      t.integer :price
      t.integer :value
      t.integer :supplier_account_id
      t.integer :min_price
      t.integer :max_price
      t.integer :stock
      t.integer :status_id

      t.timestamps
    end
  end
end
