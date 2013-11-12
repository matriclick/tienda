class CreateDressStockChangeNotifications < ActiveRecord::Migration
  def change
    create_table :dress_stock_change_notifications do |t|
      t.integer :user_id
      t.integer :dress_id
      t.integer :size_id
      t.string :color
      t.text :comments

      t.timestamps
    end
  end
end
