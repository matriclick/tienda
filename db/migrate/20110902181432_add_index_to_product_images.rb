class AddIndexToProductImages < ActiveRecord::Migration
  def up
    add_column :product_images, :image_index, :integer
    remove_column :product_images, :cover
  end
  def down
    remove_column :product_images, :image_index
    add_column :product_images, :cover, :boolean, :default => true
  end
end
