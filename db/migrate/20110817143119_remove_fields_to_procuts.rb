class RemoveFieldsToProcuts < ActiveRecord::Migration
  def up
    remove_column :products, :image_file_name
    remove_column :products, :image_content_type
    remove_column :products, :image_file_size
    remove_column :products, :image_updated_at
  end

  def down
    add_column :products, :image_file_name
    add_column :products, :image_content_type
    add_column :products, :image_file_size
    add_column :products, :image_updated_at
  end
end


