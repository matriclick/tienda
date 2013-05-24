class AddDiscountStartToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :discount_start, :date
  end
end
