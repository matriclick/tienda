class TableOfVotesForContestTravelites < ActiveRecord::Migration
  def change
    create_table :contest_travelite_votes do |t|
      t.integer :contest_travelite_id
      t.string :ip

      t.timestamps
    end
  end
end
