class AddUserIdToContestTraveliteVote < ActiveRecord::Migration
  def change
    add_column :contest_travelite_votes, :user_id, :integer
  end
end
