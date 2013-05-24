class AddFielddsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :top_price_range, :integer
    add_column :products, :price_description, :string
  end
end
