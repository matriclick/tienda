class AddDiscountToServices < ActiveRecord::Migration
  def change
    add_column :services, :discount, :decimal, :default => 0
  end
end
