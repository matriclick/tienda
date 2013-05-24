class AddImageIndexAndActiveToPlaceImages < ActiveRecord::Migration
  def change
		add_column :place_images, :active, :boolean, :default => true
		add_column :place_images, :image_index, :integer
  end
end
