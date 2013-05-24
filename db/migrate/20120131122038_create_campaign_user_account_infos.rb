class CreateCampaignUserAccountInfos < ActiveRecord::Migration
  def change
    create_table :campaign_user_account_infos do |t|
			t.belongs_to :user_account
			t.boolean :approved_by_us, :default => false
      t.text :description
      t.string :campaign_user_image_file_name
      t.integer :campaign_user_image_file_size
      t.string :campaign_user_image_content_type
      t.datetime :campaign_user_image_updated_at

      t.timestamps
    end
  end
end
