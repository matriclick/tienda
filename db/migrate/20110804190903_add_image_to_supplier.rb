class AddImageToSupplier < ActiveRecord::Migration
  def change
		add_column :suppliers, :image_file_name,    :string
    add_column :suppliers, :image_content_type, :string
    add_column :suppliers, :image_file_size,    :integer
    add_column :suppliers, :image_updated_at,   :datetime
  end
end
