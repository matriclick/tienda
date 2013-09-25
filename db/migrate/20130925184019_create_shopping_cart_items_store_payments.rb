class CreateShoppingCartItemsStorePayments < ActiveRecord::Migration
  def up
    create_table :shopping_cart_items_store_payments, :id => false do |t|
      t.integer :shopping_cart_item_id
      t.integer :store_payment_id
    end
  end

  def down
  end
end
