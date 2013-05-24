class AddDiscountToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :discount, :float
  end
end
