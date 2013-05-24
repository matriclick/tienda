class CreateSliderImages < ActiveRecord::Migration
  def change
    create_table :slider_images do |t|
      t.integer :slider_image_type_id
      t.string :slider_image_file_name
      t.string :slider_image_content_type
      t.string :slider_image_file_size
      t.string :slider_image_updated_at
      t.string :title
      t.text :content
      t.string :link

      t.timestamps
    end
  end
end
