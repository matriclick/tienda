class CreateCampaignGalleryItemImages < ActiveRecord::Migration
  def change
    create_table :campaign_gallery_item_images do |t|
      t.string :gallery_item_file_name
      t.string :gallery_item_content_type
      t.integer :gallery_item_file_size
      t.datetime :gallery_item_updated_at
			t.integer :campaign_gallery_item_id

      t.timestamps
    end
  end
end
