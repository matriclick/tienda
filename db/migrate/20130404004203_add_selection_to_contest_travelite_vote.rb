class AddSelectionToContestTraveliteVote < ActiveRecord::Migration
  def change
    add_column :contest_travelite_votes, :selection, :string
  end
end
