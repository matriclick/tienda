class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.string :title
      t.text :introduction
      t.text :description
      t.string :main_image_file_name
      t.string :main_image_content_type
      t.string :main_image_file_size
      t.string :main_image_updated_at

      t.timestamps
    end
  end
end
