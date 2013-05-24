class AddSideImageToOpportunity < ActiveRecord::Migration
  def change
    add_column :opportunities, :side_image_file_name, :string
    add_column :opportunities, :side_image_content_type, :string
    add_column :opportunities, :side_image_file_size, :string
    add_column :opportunities, :side_image_updated_at, :string
  end
end
