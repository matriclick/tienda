class CreateCampaignAnecdoteImages < ActiveRecord::Migration
  def change
    create_table :campaign_anecdote_images do |t|
      t.string :anecdote_file_name
      t.integer :anecdote_file_size
      t.string :anecdote_content_type
      t.datetime :anecdote_updated_at
      t.integer :campaign_anecdote_id

      t.timestamps
    end
  end
end
