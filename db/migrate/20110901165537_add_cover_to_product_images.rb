class AddCoverToProductImages < ActiveRecord::Migration
  def change
    add_column :product_images, :cover, :boolean
  end
end
