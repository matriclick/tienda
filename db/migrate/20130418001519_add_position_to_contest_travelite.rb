class AddPositionToContestTravelite < ActiveRecord::Migration
  def change
    add_column :contest_travelites, :position, :integer
  end
end
