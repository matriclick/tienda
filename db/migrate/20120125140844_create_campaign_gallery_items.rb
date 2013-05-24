class CreateCampaignGalleryItems < ActiveRecord::Migration
  def change
    create_table :campaign_gallery_items do |t|
      t.string :tag
      t.text :description

      t.timestamps
    end
  end
end
