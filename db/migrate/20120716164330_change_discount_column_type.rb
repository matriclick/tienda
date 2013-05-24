class ChangeDiscountColumnType < ActiveRecord::Migration
  def up
    change_column :products, :discount, :integer
    change_column :services, :discount, :integer
  end

  def down
  end
end
