class AllPositionsOfContestAre99 < ActiveRecord::Migration
  def up
    ContestTravelite.all.each do |ct|
      ct.update_attribute :position, 99
    end
  end

  def down
  end
end
