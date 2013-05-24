class ImageForContestTravelites < ActiveRecord::Migration
  def change
      add_column :contest_travelites, :contest_travelite_image_file_name, :string
      add_column :contest_travelites, :contest_travelite_image_content_type, :string
      add_column :contest_travelites, :contest_travelite_image_file_size, :integer
      add_column :contest_travelites, :contest_travelite_image_updated_at, :datetime
    end
end
