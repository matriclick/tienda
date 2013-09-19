class AddDiscountToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :discount, :float
  end
end
