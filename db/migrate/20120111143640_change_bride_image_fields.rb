class ChangeBrideImageFields < ActiveRecord::Migration
  def up
  	rename_column :bride_images, :image_file_name, :bride_file_name
  	rename_column :bride_images, :image_content_type, :bride_content_type
  	rename_column :bride_images, :image_file_size, :bride_file_size
  	rename_column :bride_images, :image_updated_at, :bride_updated_at
  end

  def down
  	rename_column :bride_images, :bride_file_name, :image_file_name
  	rename_column :bride_images, :bride_content_type, :image_content_type
  	rename_column :bride_images, :bride_file_size, :image_file_size
  	rename_column :bride_images, :bride_updated_at, :image_updated_at
  end
end
