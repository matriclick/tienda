class AddOriginalPriceToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :original_price, :integer
  end
end
