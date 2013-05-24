class AddPositionToSliderImages < ActiveRecord::Migration
  def up
    add_column :slider_images, :position, :integer
  end
 
  def down
    remove_column :slider_images, :position
  end
end
