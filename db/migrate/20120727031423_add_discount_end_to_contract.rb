class AddDiscountEndToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :discount_end, :date
  end
end
