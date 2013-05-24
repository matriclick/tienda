class CreateOpportunityImages < ActiveRecord::Migration
  def change
    create_table :opportunity_images do |t|
      t.integer :opportunity_id
      t.string :caption
      t.string :opportunity_image_file_name
      t.string :opportunity_image_content_type
      t.string :opportunity_image_file_size
      t.date :opportunity_image_updated_at

      t.timestamps
    end
  end
end
