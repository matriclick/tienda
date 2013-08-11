class AddStorePaidToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :store_paid, :boolean
  end
end
