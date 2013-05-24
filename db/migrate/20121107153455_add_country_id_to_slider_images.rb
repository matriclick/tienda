class AddCountryIdToSliderImages < ActiveRecord::Migration
  def change
    add_column :slider_images, :country_id, :integer
  end
end
