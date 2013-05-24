class ChangeGroomImageFields < ActiveRecord::Migration
  def up
  	rename_column :groom_images, :image_file_name, :groom_file_name
  	rename_column :groom_images, :image_content_type, :groom_content_type
  	rename_column :groom_images, :image_file_size, :groom_file_size
  	rename_column :groom_images, :image_updated_at, :groom_updated_at
  end

  def down
  	rename_column :groom_images, :groom_file_name, :image_file_name
  	rename_column :groom_images, :groom_content_type, :image_content_type
  	rename_column :groom_images, :groom_file_size, :image_file_size
  	rename_column :groom_images, :groom_updated_at, :image_updated_at
  end
end
