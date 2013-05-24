class AddSlugToCampaignAnecdotes < ActiveRecord::Migration
  def change
    add_column :campaign_anecdotes, :slug, :string
    add_index :campaign_anecdotes, :slug
  end
end
