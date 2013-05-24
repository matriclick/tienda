class CreateCampaignAnecdotes < ActiveRecord::Migration
  def change
    create_table :campaign_anecdotes do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
