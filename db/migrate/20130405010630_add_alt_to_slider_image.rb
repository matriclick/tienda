class AddAltToSliderImage < ActiveRecord::Migration
  def change
    add_column :slider_images, :alt, :boolean
  end
end
