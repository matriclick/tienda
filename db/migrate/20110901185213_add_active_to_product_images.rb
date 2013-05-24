class AddActiveToProductImages < ActiveRecord::Migration
  def change
    add_column :product_images, :active, :boolean, :default => true
  end
end
