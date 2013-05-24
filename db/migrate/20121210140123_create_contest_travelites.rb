class CreateContestTravelites < ActiveRecord::Migration
  def change
    create_table :contest_travelites do |t|
      t.integer :user_id
      t.integer :vote_count, :default => 0
      t.string :selection

      t.timestamps
    end
  end
end
